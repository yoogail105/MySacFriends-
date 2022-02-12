//
//  QueueAPI.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/02/10.
//
import Foundation
import Moya



enum QueueService {
    case queue(param: QueueRequest)
    case onQueue(param: OnQueueRequest)
}


extension QueueService: TargetType {
    
    var baseURL: URL {
        return URL(string: GeneralAPIComponents.baseURL)!
    }
    
    var path: String {
        switch self {
        case .queue:
            return "queue"
        case .onQueue:
            return "queue/onQueue"
            
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .queue, .onQueue:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .queue(let param):
            return .requestJSONEncodable(param)
            
        case .onQueue(let param):
            return .requestParameters(parameters: [
                "region": param.region,
                "lat": param.lat,
                "long": param.long
            ], encoding: URLEncoding.default)

            
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return [
                APIHeader.idtoken.rawValue : GeneralAPIComponents.idToken,
                APIHeader.ContentType.rawValue : GeneralAPIComponents.ContentType
            ]
        }
    }
}
