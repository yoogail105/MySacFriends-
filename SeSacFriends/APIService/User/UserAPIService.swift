//
//  SignUpAPIService.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/24.
//

import Foundation
import Moya
import UIKit

class UserAPIService {
    
    let userDefaults = UserDefaults.standard
    static private let provider = MoyaProvider<UserService>()
    
    static func login(_ completion: @escaping (User?, APIErrorCode?) -> Void) {
        provider.request(.signIn) { result in
            switch ResponseData<User>.processJSONResponse(result) {
            case .success(let model):
                return completion(model, nil)
            case .failure(let error):
                return completion(nil, error)
            }
        }
    }
    
    static func signUp(param: SignUpRequest, _ completion: @escaping (User?, APIErrorCode?) -> Void) {
        provider.request(.signUp(param: param)) { result in
            switch ResponseData<User>.processJSONResponse(result){
            case .success(let model):
                return completion(model, nil)
            case .failure(let error):
                return completion(nil, error)
            }
        }
    }
    
    // 회원 삭제하기 -> FCM 토큰 강제 갱신해줘야 한다.
    static func withdrawalUser(_ completion: @escaping (String?, APIErrorCode?) -> Void) {
        provider.request(.withdraw) { result in
            switch ResponseData<String>.processResponse(result) {
            case .success(let model):
                return completion(model, nil)
            case .failure(let error):
                return completion(nil, error)
            }
        }
    }
    
    // FCM토큰 업데이트
    static func updateFCMToken(param: UpdateFCMToken, _ completion: @escaping (String?, APIErrorCode?) -> Void) {
        provider.request(.updateFCMToken(param: param)) { result in
            switch ResponseData<String>.processResponse(result) {
            case .success(let model):
                return completion(model, nil)
            case .failure(let error):
                return completion(nil, error)
            }
        }
    }
    // 내정보 업데이트
    static func updateMyPage(param: UpdateMyPageRequest, _ completion: @escaping (String?, APIErrorCode?) -> Void) {
        provider.request(.updateMyPage(param: param)) { result in
            switch ResponseData<String>.processResponse(result){
            case .success(let model):
                return completion(model, nil)
            case .failure(let error):
                return completion(nil, error)
            }
        }
    }
}
