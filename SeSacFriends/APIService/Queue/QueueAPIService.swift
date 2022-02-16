//
//  QueueAPIService.swift
//
//
//  Created by 성민주민주 on 2022/01/27.
//

import Foundation
import Moya
import RxSwift

final class QueueAPIService {
    
    static private let provider = MoyaProvider<QueueService>()
    
    static func requestFindHobbyFriends(completion: @escaping (User?, APIErrorCode?) -> Void) {
        
        
        let idToken = UserDefaults.standard.idToken!
        print("signup에서 idtoken: ", idToken)
        var request = URLRequest(url: QueueEndpoint.queue.url)
        
        request.httpMethod = Method.POST.rawValue
        
        request.setValue(idToken, forHTTPHeaderField: HTTPString.idtoken.rawValue)
        request.setValue(HTTPHeaderValue.contentType.rawValue, forHTTPHeaderField: HTTPString.ContentType.rawValue)
        request.httpBody = "type=2&region=1274830692&long=126.92983890550006&lat= 37.482733667903865&hf=[]".data(using: .utf8, allowLossyConversion: false)
       
        URLSession.request(endpoint: request, completion: completion)
    
    }
    
    // queue
    static func requestFindHobbyFriends2(param: QueueRequest, completion: @escaping (Friends?, APIErrorCode?) -> Void) {
        
        provider.request(.requestFindHobbyFriends(param: param)) { result in
            
            print("결과:", result)
            switch ResponseData<Friends>.processResponse(result) {
            case .success(let model):
                return completion(model, nil)
            case .failure(let error):
                return completion(nil, error)
            }
        }
    }
    
    // onqueue
    static func searchHobbyFriends(param: OnQueueRequest, completion: @escaping (Friends?, APIErrorCode?) -> Void) {
        
        provider.request(.onQueue(param: param)) { result in
            switch ResponseData<Friends>.processJSONResponse(result) {
            case .success(let model):
                return completion(model, nil)
            case .failure(let error):
                return completion(nil, error)
            }
        }
    }
    
    static func requestTogether(param: HobbyRequest, completion: @escaping (Friends?, APIErrorCode?) -> Void) {
        
        provider.request(.hobbyRequest(param: param)) { result in
            switch ResponseData<Friends>.processResponse(result) {
            case .success(let model):
                return completion(model, nil)
            case .failure(let error):
                return completion(nil, error)
            }
        }
    }
    
    static func acceptTogether(param: HobbyRequest, completion: @escaping (Friends?, APIErrorCode?) -> Void) {
        
        provider.request(.hobbyAccept(param: param)) { result in
            switch ResponseData<Friends>.processResponse(result) {
            case .success(let model):
                return completion(model, nil)
            case .failure(let error):
                return completion(nil, error)
            }
        }
    }
    
    // myQueueStatus
    static func myQueueStatus( completion: @escaping (MyQueueState?, APIErrorCode?) -> Void) {
        
        provider.request(.myQueueState) { result in
            switch ResponseData<MyQueueState>.processJSONResponse(result) {
            case .success(let model):
                return completion(model, nil)
            case .failure(let error):
                return completion(nil, error)
            }
        }
    }
    
    
    static func stopFindingHobbyFriends( completion: @escaping (Friends?, APIErrorCode?) -> Void) {
        
        provider.request(.stopFindingHobbyFriends) { result in
            switch ResponseData<Friends>.processJSONResponse(result) {
            case .success(let model):
                return completion(model, nil)
            case .failure(let error):
                return completion(nil, error)
            }
        }
    }
    
    static func stopSearchFriends( completion: @escaping (Friends?, APIErrorCode?) -> Void) {
        
        provider.request(.stopFindingHobbyFriends) { result in
            switch ResponseData<Friends>.processJSONResponse(result) {
            case .success(let model):
                return completion(model, nil)
            case .failure(let error):
                return completion(nil, error)
            }
        }
    }
    
}
