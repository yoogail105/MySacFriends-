//
//  SignUpAPIService.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/24.
//

import Foundation

class SignUpAPIService {
    
    let userDefaults = UserDefaults.standard
    
    static func login(completion: @escaping (User?, APIError?) -> Void ) {
        
        let idToken = UserDefaults.standard.idToken!
        print("fetchUser idToken: \(idToken)")
        var request = URLRequest(url: Endpoint.user.url)
        
        request.httpMethod = Method.GET.rawValue
        
        request.setValue(idToken, forHTTPHeaderField: HTTPString.idtoken.rawValue)
       // request.setValue(HTTPHeaderValue.contentType.rawValue, forHTTPHeaderField: HTTPString.ContentType.rawValue)
        
        URLSession.request(endpoint: request, completion: completion)
    }
    
    
    static func signUp(completion: @escaping (User?, APIError?) -> Void) {
        let idToken = UserDefaults.standard.idToken!
        print("signup에서 idtoken: ", idToken)
        var request = URLRequest(url: Endpoint.user.url)
        
        request.httpMethod = Method.POST.rawValue
        
        request.setValue(idToken, forHTTPHeaderField: HTTPString.idtoken.rawValue)
        request.setValue(HTTPHeaderValue.contentType.rawValue, forHTTPHeaderField: HTTPString.ContentType.rawValue)
        
        request.httpBody = "\(UserBodyPara.phoneNumber.rawValue)=\(UserDefaults.standard.phoneNumber)&\(UserBodyPara.FCMtoken)=\(UserDefaults.standard.FCMToken!)&\(UserBodyPara.nick.rawValue)=\(UserDefaults.standard.nickname)&\(UserBodyPara.birth.rawValue)=\(UserDefaults.standard.birth!)&\(UserBodyPara.email.rawValue)=\(UserDefaults.standard.email)&\(UserBodyPara.gender.rawValue)=\(UserDefaults.standard.gender)"
            .data(using: .utf8, allowLossyConversion: false)
        print("\(UserBodyPara.phoneNumber.rawValue)=\(UserDefaults.standard.phoneNumber)\n&\(UserBodyPara.FCMtoken)=\(UserDefaults.standard.FCMToken!)\n&\(UserBodyPara.nick.rawValue)=\(UserDefaults.standard.nickname)\n&\(UserBodyPara.birth.rawValue)=\(UserDefaults.standard.birth!)\n&\(UserBodyPara.email.rawValue)=\(UserDefaults.standard.email)\n&\(UserBodyPara.gender.rawValue)=\(UserDefaults.standard.gender)")
       
        URLSession.request(endpoint: request, completion: completion)
        
    }
}
