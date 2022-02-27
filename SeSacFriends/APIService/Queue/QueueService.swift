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
    case cancelAppointment(param: HobbyRequest)
    case rate(param: RateRequest)
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
        case .cancelAppointment:
            return "queue/dodge"
        // 수정: 요청패쓰 : 상대방 유저 아이디
        case .rate:
            return "queue/rate/{id}"

            
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .requestFindHobbyFriends, .onQueue, .hobbyRequest, .hobbyAccept, .cancelAppointment, .rate:
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
            return .requestParameters(parameters: [
                "type": param.type,
                "region": param.region,
                "lat": param.lat,
                "long": param.long,
                "hf": param.hf
            ], encoding: URLEncoding(arrayEncoding: .noBrackets))
            
        case .onQueue(let param):
            return .requestParameters(parameters: [
                "region": param.region,
                "lat": param.lat,
                "long": param.long
            ], encoding: URLEncoding.default)
        case .hobbyRequest(let param), .hobbyAccept(let param), .cancelAppointment(let param):
            return .requestParameters(parameters: [
                "otheruid": param.otheruid
            ], encoding: URLEncoding.default)
            
        case .rate(let param):
            return .requestParameters(parameters: [
                "otheruid": param.otheruid,
                "reputation": param.reputation,
                "comment": param.comment
            ], encoding: URLEncoding.default)
        case .myQueueState, .stopFindingHobbyFriends:
            return .requestPlain
            
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .requestFindHobbyFriends:
            return [APIHeader.idtoken.rawValue : GeneralAPIComponents.idToken]
            
        default:
            return [
                APIHeader.idtoken.rawValue : GeneralAPIComponents.idToken,
                APIHeader.ContentType.rawValue : GeneralAPIComponents.ContentType
            ]
        }
    }
}
