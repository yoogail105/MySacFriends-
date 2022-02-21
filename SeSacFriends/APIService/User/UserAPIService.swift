//
//  SignUpAPIService.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/24.
//

import Foundation
import Moya
import simd

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
    
    // 로그인하기: 번호인증 후, 로그인이 안되어있다면
    static func login2(completion: @escaping (User?, APIErrorCode?) -> Void ) {
        
        let idToken = UserDefaults.standard.idToken!
        print("fetchUser idToken: \(idToken)")
        var request = URLRequest(url: Endpoint.user.url)
        
        request.httpMethod = Method.GET.rawValue
        
        request.setValue(idToken, forHTTPHeaderField: HTTPString.idtoken.rawValue)
       // request.setValue(HTTPHeaderValue.contentType.rawValue, forHTTPHeaderField: HTTPString.ContentType.rawValue)
        
        URLSession.requestWithCodable(endpoint: request, completion: completion)
    }
    
    
    static func signUp(completion: @escaping (User?, APIErrorCode?) -> Void) {
        
        
        let idToken = UserDefaults.standard.idToken!
        print("signup에서 idtoken: ", idToken)
        var request = URLRequest(url: Endpoint.user.url)
        
        request.httpMethod = Method.POST.rawValue
        
        request.setValue(idToken, forHTTPHeaderField: HTTPString.idtoken.rawValue)
        request.setValue(HTTPHeaderValue.contentType.rawValue, forHTTPHeaderField: HTTPString.ContentType.rawValue)
 
        request.httpBody = "\(UserBodyPara.phoneNumber.rawValue)=\(UserDefaults.standard.phoneNumber)&\(UserBodyPara.FCMtoken.rawValue)=\(UserDefaults.standard.FCMToken!)&\(UserBodyPara.nick.rawValue)=\(UserDefaults.standard.nickname)&\(UserBodyPara.birth.rawValue)=\(UserDefaults.standard.birth!)&\(UserBodyPara.email.rawValue)=\(UserDefaults.standard.email)&\(UserBodyPara.gender.rawValue)=\(UserDefaults.standard.gender)".data(using: .utf8, allowLossyConversion: false)
       
        print("\(UserBodyPara.phoneNumber.rawValue)=\(UserDefaults.standard.phoneNumber)\n&\(UserBodyPara.FCMtoken)=\(UserDefaults.standard.FCMToken!)\n&\(UserBodyPara.nick.rawValue)=\(UserDefaults.standard.nickname)\n&\(UserBodyPara.birth.rawValue)=\(UserDefaults.standard.birth!)\n&\(UserBodyPara.email.rawValue)=\(UserDefaults.standard.email)\n&\(UserBodyPara.gender.rawValue)=\(UserDefaults.standard.gender)")
       
        URLSession.request(endpoint: request, completion: completion)
        
    }
    
    // 회원 삭제하기 -> FCM 토큰 강제 갱신해줘야 한다.
    static func withdrawalUser(completion: @escaping (User?, APIErrorCode?) -> Void) {
        let idToken = UserDefaults.standard.idToken!
        let fcmToken = UserDefaults.standard.FCMToken!
        var request = URLRequest(url: Endpoint.deleteUser.url)
        
        request.httpMethod = Method.POST.rawValue
        request.httpBody = "\(UserBodyPara.FCMtoken.rawValue)=\(fcmToken)".data(using: .utf8, allowLossyConversion: false)
        request.setValue(idToken, forHTTPHeaderField: HTTPString.idtoken.rawValue)
        request.setValue(HTTPHeaderValue.contentType.rawValue, forHTTPHeaderField: HTTPString.ContentType.rawValue)
        
        URLSession.request(endpoint: request, completion: completion)
    }
    
    // FCM토큰 업데이트
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
