//
//  QueueAPI.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/02/10.
//
import Foundation
import Moya



enum QueueService {
    case requestFindHobbyFriends(param: QueueRequest)
    case onQueue(param: OnQueueRequest)
    case hobbyRequest(param: HobbyRequest)
    case hobbyAccept(param: HobbyRequest)
    case myQueueState
    case stopFindingHobbyFriends
}


extension QueueService: TargetType {
    
    var baseURL: URL {
        return URL(string: GeneralAPIComponents.baseURL)!
    }
    
    var path: String {
        switch self {
        case .requestFindHobbyFriends, .stopFindingHobbyFriends:
            return "queue"
        case .onQueue:
            return "queue/onqueue"
        case .hobbyRequest:
            return "queue/hobbyrequest"
        case .hobbyAccept:
            return "queue/hobbyaccept"
        case .myQueueState:
            return "queue/myQueueState"

            
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .requestFindHobbyFriends, .onQueue,  .hobbyRequest, .hobbyAccept:
            return .post
        case .myQueueState:
            return .get
        case .stopFindingHobbyFriends:
            return .delete
        }
    }
    
    var task: Task {
        switch self {
        case .requestFindHobbyFriends(let param):
            return .requestJSONEncodable(param)
            
        case .onQueue(let param):
            return .requestParameters(parameters: [
                "region": param.region,
                "lat": param.lat,
                "long": param.long
            ], encoding: URLEncoding.default)
        case .hobbyRequest(let param), .hobbyAccept(let param):
            return .requestParameters(parameters: [
                "otheruid": param.otheruid
            ], encoding: URLEncoding.default)
            
        case .myQueueState, .stopFindingHobbyFriends:
            return .requestPlain
            
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
