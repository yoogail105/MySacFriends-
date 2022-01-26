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
    case user
    case deleteUser
    case updateFCMToken
    case updateMyPage
    case userUpdateFCMToken
}

enum HTTPString: String {
    case idtoken
    case ContentType = "Content-Type"
    
}

enum HTTPHeaderValue: String {
    case contentType = "application/x-www-form-urlencoded"
}

enum UserBodyPara: String {
    case phoneNumber
    case FCMtoken
    case nick
    case birth
    case email
    case gender
    case searchable
    case ageMin
    case ageMax
    case hobby
    
}

extension Endpoint {
    var url: URL {
        switch self {
        case .user:
            return .makeEndPoint("/user")
        case .deleteUser:
            return .makeEndPoint("/user/withdraw")
        case .updateFCMToken:
            return .makeEndPoint("/user/update_fcm_token")
        case.updateMyPage:
            return .makeEndPoint("/user/update/mypage")
        case .userUpdateFCMToken:
            return .makeEndPoint("/user/update_fcm_token")
            
        }
    }
}

extension URL {
    static let baseURL = "http://test.monocoding.com:35484"
    
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
    
    static func request<T: Decodable>(_ session: URLSession = .shared, endpoint: URLRequest, completion: @escaping (T?, APIErrorCode?) -> Void) {
        
        session.dataTask(endpoint) { data, response, error in
            let str = String(decoding: data!, as: UTF8.self)
            print("data: ",str)
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
                
                guard response.statusCode == APIErrorCode.ok.rawValue else {
                    let statusCode = response.statusCode
                    switch statusCode {
                    case APIErrorCode.created.rawValue: //201
                        completion(nil, .created)
                    case APIErrorCode.invalidNickname.rawValue: //202
                        completion(nil, .invalidNickname)
                    case APIErrorCode.unAuthorized.rawValue: //401
                        completion(nil, .unAuthorized)
                    case APIErrorCode.notAcceptable.rawValue: //406
                        completion(nil, .notAcceptable)
                    default:
                        print("error: \(str)")
                        completion(nil, .internalServerError)
                    }
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let userData = try decoder.decode(T.self, from: data)
                    completion(userData, nil)
                    print("codable Ok")
                    return
                    
                } catch {
                    print("do-catch: codable 오류")
                    completion(nil, .invalidData)
                    return
                    
                }
            }
        }
    }
}
