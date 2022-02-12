//
//  UserService.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/02/12.
//

import Foundation
import Moya

enum UserService {
    case signIn
    case signUp(param: SignUpRequest)
    case withdraw
    case updateFCMToken(param: UpdateFCMToken)
    case updateMyPage(param: UpdateMyPageRequest)
}

extension UserService: TargetType {
    
    var baseURL: URL {
        return URL(string: GeneralAPIComponents.baseURL)!
    }
    
    var path: String {
        switch self {
        case .signIn:
            return "user"
        case .signUp:
            return  "user"
        case .withdraw:
            return "user/withdraw"
        case .updateFCMToken:
            return "user/update_fcm_token"
        case .updateMyPage:
            return "usr/update/mypage"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .signIn:
            return .get
        case .signUp, .withdraw, .updateMyPage:
            return .post
        case .updateFCMToken:
            return .put
        }
    }
    
    var task: Task {
        switch self {
        case .signIn, .withdraw:
            return .requestPlain
            
        case .signUp(let param):
            return .requestParameters(parameters: [
                "phoneNumber": param.phoneNumber,
                "FCMtoken": param.FCMtoken,
                "nick": param.nick,
                "birth": param.birth,
                "email": param.email,
                "gender": param.gender
            ], encoding: URLEncoding.default)
            
        case .updateFCMToken(let param):
            return .requestParameters(parameters: [
                "FCMtoken": param.FCMtoken
            ], encoding: URLEncoding.default)
            
            
        case .updateMyPage(let param):
            return .requestParameters(parameters: [
                "searchable": param.searchable,
                "ageMin": param.ageMin,
                "ageMax": param.ageMax,
                "gender": param.gender,
                "hobby": param.hobby
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

