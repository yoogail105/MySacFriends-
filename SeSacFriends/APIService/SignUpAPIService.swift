//
//  SignUpAPIService.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/24.
//

import Foundation

class SignUpAPIService {
    static func fetchUser(completion: @escaping (User?, APIError?) -> Void ) {
        
        let idToken = UserDefaults.standard.idToken!
        print("fetchUser idToken: \(idToken)")
        var request = URLRequest(url: Endpoint.user.url)
        
        request.httpMethod = Method.GET.rawValue
        
        request.setValue(idToken, forHTTPHeaderField: "idtoken")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.request(endpoint: request, completion: completion)
    }
}
