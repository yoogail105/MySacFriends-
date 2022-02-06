//
//  QueueAPIService.swift
//
//
//  Created by 성민주민주 on 2022/01/27.
//

import Foundation
class QueueAPIService {
    
    
    static func requestFriends(region: Int, lat: Double, long: Double, hf: [String], completion: @escaping (User?, APIErrorCode?) -> Void) {
        let userDefaults = UserDefaults.standard
        var request = URLRequest(url: QueueEndpoint.queue.url)
        request.httpMethod = Method.POST.rawValue
        
        let idToken = userDefaults.idToken!
        request.setValue(idToken, forHTTPHeaderField: HTTPString.idtoken.rawValue)
        request.setValue(HTTPHeaderValue.contentType.rawValue, forHTTPHeaderField: HTTPString.ContentType.rawValue)
        
        request.httpBody = "\(QueueBodyPara.friendsGender.rawValue)=2&\(QueueBodyPara.region.rawValue)=\(region)&\(QueueBodyPara.long.rawValue)=\(lat)&\(QueueBodyPara.lat.rawValue)=\(long)&\(QueueBodyPara.hobbyArray.rawValue)=\(hf)".data(using: .utf8, allowLossyConversion: false)
        
        
        URLSession.requestWithCodable(endpoint: request, completion: completion)
    }
    
    
    static func searchFriends(completion: @escaping (User?, APIErrorCode?) -> Void) {
        let userDefaults = UserDefaults.standard
        
        var request = URLRequest(url: QueueEndpoint.onQueue.url)
        request.httpMethod = Method.POST.rawValue
        
        let idToken = userDefaults.idToken!
        request.setValue(idToken, forHTTPHeaderField: HTTPString.idtoken.rawValue)
        request.setValue(HTTPHeaderValue.contentType.rawValue, forHTTPHeaderField: HTTPString.ContentType.rawValue)
        
        request.httpBody = "\(QueueBodyPara.region.rawValue)=\(userDefaults.searchable)&\(QueueBodyPara.lat.rawValue)=\(userDefaults.ageMin)&\(QueueBodyPara.long.rawValue)=\(userDefaults.ageMax)".data(using: .utf8, allowLossyConversion: false)
        
        
        URLSession.requestWithCodable(endpoint: request, completion: completion)
    }
    
    static func stopSearchFriends(completion: @escaping (User?, APIErrorCode?) -> Void) {
        let userDefaults = UserDefaults.standard
        let idToken = userDefaults.idToken!
        var request = URLRequest(url: QueueEndpoint.queue.url)
        
        request.httpMethod = Method.DELETE.rawValue
        request.setValue(idToken, forHTTPHeaderField: HTTPString.idtoken.rawValue)

        URLSession.requestWithCodable(endpoint: request, completion: completion)
    }
    
}
