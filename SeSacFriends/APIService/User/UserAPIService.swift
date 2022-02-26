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
                print("login: \(model)")
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
                print("signUp: \(model)")
                return completion(model, nil)
            case .failure(let error):
                return completion(nil, error)
            }
        }
    }
    
    // 회원 삭제하기 -> FCM 토큰 강제 갱신해줘야 한다.
    static func withdrawalUser(_ completion: @escaping (User?, APIErrorCode?) -> Void) {
        provider.request(.withdraw) { result in
            switch ResponseData<User>.processResponse(result) {
            case .success(let model):
                print("signUp: \(model)")
                return completion(model, nil)
            case .failure(let error):
                return completion(nil, error)
            }
        }
    }
    
    // FCM토큰 업데이트
    static func updateFCMToken(param: UpdateFCMToken, _ completion: @escaping (User?, APIErrorCode?) -> Void) {
        provider.request(.updateFCMToken(param: param)) { result in
            switch ResponseData<User>.processResponse(result) {
            case .success(let model):
                print("updateFCMToken: \(model)")
                return completion(model, nil)
            case .failure(let error):
                return completion(nil, error)
            }
        }
    }
    
    static func updateFCMToken(completion: @escaping (User?, APIErrorCode?) -> Void) {
        
        var request = URLRequest(url: Endpoint.updateFCMToken.url)
        request.httpMethod = Method.PUT.rawValue
        
        let idToken = UserDefaults.standard.idToken!
        request.setValue(idToken, forHTTPHeaderField: HTTPString.idtoken.rawValue)
        request.setValue(HTTPHeaderValue.contentType.rawValue, forHTTPHeaderField: HTTPString.ContentType.rawValue)
        
        URLSession.requestWithCodable(endpoint: request, completion: completion)
        
    }
    
    // 내정보 업데이트
    static func updateMyPage(searchable: Int, ageMin: Int, ageMax: Int, gender: Int, hobby: String, completion: @escaping (User?, APIErrorCode?) -> Void) {
        
        var request = URLRequest(url: Endpoint.updateMyPage.url)
        request.httpMethod = Method.POST.rawValue
        
        let idToken = UserDefaults.standard.idToken!
        request.setValue(idToken, forHTTPHeaderField: HTTPString.idtoken.rawValue)
        request.setValue(HTTPHeaderValue.contentType.rawValue, forHTTPHeaderField: HTTPString.ContentType.rawValue)
        
        request.httpBody = "\(UserBodyPara.searchable.rawValue)=\(searchable)&\(UserBodyPara.ageMin.rawValue)=\(ageMin)&\(UserBodyPara.ageMax)=\(ageMax)&\(UserBodyPara.gender.rawValue)=\(gender)&\(UserBodyPara.hobby.rawValue)=\(hobby)".data(using: .utf8, allowLossyConversion: false)
        
        print( "내가 보낸 정보는: \(UserBodyPara.searchable.rawValue)=\(searchable)&\(UserBodyPara.ageMin.rawValue)=\(ageMin)&\(UserBodyPara.ageMax)=\(ageMax)&\(UserBodyPara.gender.rawValue)=\(gender)&\(UserBodyPara.hobby.rawValue)=\(hobby)")
        
        
        
        URLSession.request(endpoint: request, completion: completion)
    }
    
}
