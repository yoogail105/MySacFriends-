//
//  Endpoint.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/23.
//

import Foundation

enum Method: String {
    case GET
    case POST
    case PUT
    case DELETE
}

enum Endpoint {
    case signUp
    case signIn
    case changePW
    case posts(startIndex: Int, endIndex: Int, sort: String)
    case addPost
    case postDetail(id: Int)
    case comments(id: Int)
    case addComments
    case commentDetail(id: Int)
}

enum Sort: String {
    case asc
    case desc
}

extension Endpoint {
    var url: URL {
        switch self {
        case .signUp:
            return .makeEndPoint("auth/local/register")
        case .signIn:
            return .makeEndPoint("auth/local")
        case .changePW:
            return .makeEndPoint("custom/change-password")
        case .posts(startIndex: let startIndex, endIndex: let endIndex, sort: let sort):
            return .makeEndPoint("posts?_start=\(startIndex)&_limit=\(endIndex)&_sort=created_at:\(sort)")
        case .addPost:
            return .makeEndPoint("posts")
        case .postDetail(id: let id):
            return .makeEndPoint("posts/\(id)")
        case .comments(id: let id):
            return .makeEndPoint("comments?post=\(id)")
        case .addComments:
            return .makeEndPoint("comments")
        case .commentDetail(id: let id):
            return .makeEndPoint("comments/\(id)")
            
            
        }
    }
}
// http://test.monocoding.com/auth/local
// http://test.monocoding.com:1231/auth/local

extension URL {
    static let baseURL = "http://test.monocoding.com:1231/"
    
    static func makeEndPoint(_ endpoint: String) -> URL {
        URL(string: baseURL + endpoint)!
        
    }
    
}

extension URLSession {
    
    typealias Handler = (Data?, URLResponse?, Error?) -> Void
    
    @discardableResult
    func dataTask(_ endpoint: URLRequest, handler: @escaping Handler) -> URLSessionDataTask {
        let task = dataTask(with: endpoint, completionHandler: handler)
        task.resume()
        return task
    }
    
    static func request<T: Decodable>(_ session: URLSession = .shared, endpoint: URLRequest, completion: @escaping (T?, APIError?) -> Void) {
        
        session.dataTask(endpoint) { data, response, error in
            
            let str = String(decoding: data!, as: UTF8.self)
            //print("결과:::::::\n data: \(str)")
            print("결과:::::::\n response: \(response)\n error: \(error)")
            
            DispatchQueue.main.async {
                guard error == nil else {
                    completion(nil, .failed)
                    return
                }
                
                guard let data = data else {
                    completion(nil, .noData)
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    print("error3: 여기오류")
                    completion(nil, .invalidData)
                    return
                }
                
                guard response.statusCode == 200 else {
                    
                    if response.statusCode == 401 {
                        print("토큰이 만료되었습니다.")
                        UserDefaults.standard.reset()
                        BaseViewController().isTokenExpired = true
                        
                        completion(nil, .unAuthorized)
                        return
                    }
                    
                    if response.statusCode == 400 {
                        completion(nil, .invalidData)
                        return
                    }
                    
                    
                    //                    else { completion(nil, .failed) }
                    
                    // 오류 확인
                    do {
                        print("statusCode: ", response.statusCode)
                        
                        let decoder = JSONDecoder()
                        let errorDetail = try decoder.decode(ErrorDetail.self, from: data)
                        completion(nil, .failed)
                        print("error:", errorDetail.message)
                        return
                    } catch {
                        print("status code do-catch: 여기오류")
                        
                        completion(nil, .invalidData)
                        return
                    }
                }
                
                
                do {
                    let decoder = JSONDecoder()
                    let userData = try decoder.decode(T.self, from: data)
                    completion(userData, nil)
                    print("Ok")
                } catch {
                    print("do-catch: 여기오류")
                    completion(nil, .invalidData)
                }
            }
        }
    }
}
