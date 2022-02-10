//
//  QueueAPI.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/02/10.
//

import Moya

enum QueueAPI {
    case queue
    case onQueue(_ region: Int, _ lat: Double, _ long: Double)
}


extension QueueAPI: TargetType {

    var baseURL: URL {
        return URL(string: "http://test.monocoding.com:35484")!
    }

    var path: String {
        switch self {
        case .queue:
            return "/queue"
        case .onQueue(_, _, _):
            return "/queue/onqueue"
        }
    }
    
    
    
    var method: Moya.Method {
        switch self {
        case .queue:
            return .post
        case .onQueue:
            return .post
        }
    }

    var task: Task {
        switch self {
        case .queue:
            return .requestPlain

        case .onQueue(let region, let lat, let long):
            let params: [String: Any] = [
                "region": region,
                "lat": lat,
                "long": long
                ]
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)

        }
    }

    var headers: [String : String]? {
        return [HTTPString.ContentType.rawValue: HTTPHeaderValue.contentType.rawValue]
    }


}
