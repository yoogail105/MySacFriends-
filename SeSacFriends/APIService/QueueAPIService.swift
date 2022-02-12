//
//  QueueAPIService.swift
//
//
//  Created by 성민주민주 on 2022/01/27.
//

import Foundation
import Moya

final class QueueAPIService {
    
    static private let provider = MoyaProvider<QueueService>()
    
    // MARK: queue

    static func searchHobbyFriends(param: OnQueueRequest, completion: @escaping (Friends?, APIErrorCode?) -> Void) {
        
        provider.request(.onQueue(param: param)) { result in
//            print("온큐결과", result)
//            switch result {
//            case .success(let response):
//                let result = try?  response.map(Friends.self)
//                print("성공: ", response)
//                completion(result, nil)
//            case .failure(let error):
//                print("시류ㅐ: ", error)
//                completion(nil, APIErrorCode(rawValue: error.response!.statusCode))
//                      }
            
            
            switch ResponseData<Friends>.processJSONResponse(result) {
            case .success(let model):
                print("api통신은 성고헀슴: ", model)
                return completion(model, nil)
            case .failure(let error):
                return completion(nil, error)
            }
        }
    }
    
    // MARK: onQueue
    // 새싹어노테이션띄우기
    
    
    static func searchFriends(region: Int, lat: Double, long: Double, completion: @escaping (Friends?, APIErrorCode?) -> Void) {
        let userDefaults = UserDefaults.standard
        
        
        var request = URLRequest(url: QueueEndpoint.onQueue.url)
        request.httpMethod = Method.POST.rawValue
        
        let idToken = userDefaults.idToken!
        request.setValue(idToken, forHTTPHeaderField: HTTPString.idtoken.rawValue)
        request.setValue(HTTPHeaderValue.contentType.rawValue, forHTTPHeaderField: HTTPString.ContentType.rawValue)
        
        request.httpBody = "\(QueueBodyPara.region.rawValue)=\(region)&\(QueueBodyPara.lat.rawValue)=\(lat)&\(QueueBodyPara.long.rawValue)=\(long)".data(using: .utf8, allowLossyConversion: false)
        
        URLSession.requestWithCodable(endpoint: request, completion: completion)
    }
    
    
    
    static func stopSearchFriends(completion: @escaping (User?, APIErrorCode?) -> Void) {
        let userDefaults = UserDefaults.standard
        let idToken = userDefaults.idToken!
        var request = URLRequest(url: QueueEndpoint.queue.url)
        
        request.httpMethod = Method.DELETE.rawValue
        request.setValue(idToken, forHTTPHeaderField: HTTPString.idtoken.rawValue)
        
        URLSession.requestWithCodable(endpoint: request, completion: completion)
    }
    
}
