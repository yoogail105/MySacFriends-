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
}


extension Endpoint {
    var url: URL {
        switch self {
        case .user:
            return .makeEndPoint("/user")
        case .deleteUser:
            return .makeEndPoint("/user/withdraw")
            
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
    
    static func request<T: Decodable>(_ session: URLSession = .shared, endpoint: URLRequest, completion: @escaping (T?, APIError?) -> Void) {
        
        session.dataTask(endpoint) { data, response, error in
            let str = String(decoding: data!, as: UTF8.self)
            print("data: ",data)
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
                    
                    if response.statusCode == 201 {
                        print("201: 사용자 정보 없음")
                        UserDefaults.standard.startMode = StartMode.signUp.rawValue
                        AuthVerificationCodeViewController().selectNextView()
                        completion(nil, .invalidData)
                        return
                    }
                    
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let userData = try decoder.decode(T.self, from: data)
                    completion(userData, nil)
                    print("Ok")
                } catch {
                    print("do-catch: codable 오류")
                    completion(nil, .invalidData)
                }
            }
        }
    }
}
