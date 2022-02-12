//
//  UserRequest.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/02/12.
//

import Foundation

struct SignUpRequest: Codable {
    var phoneNumber: Int
    var FCMtoken: Int
    var nick: Double
    var birth: Double
    var email: [String]
    var gender: Int
    
    internal init(phoneNumber: Int, FCMtoken: Int, nick: Double, birth: Double, email: [String], gender: Int) {
        self.phoneNumber = phoneNumber
        self.FCMtoken = FCMtoken
        self.nick = nick
        self.birth = birth
        self.email = email
        self.gender = gender
    }
}


struct UpdateFCMToken: Codable {
    var FCMtoken: String
    internal init(FCMtoken: String) {
        self.FCMtoken = FCMtoken
    }
    
}
//post
struct UpdateMyPageRequest: Codable {
    var searchable: Int
    var ageMin: Int
    var ageMax: Int
    var gender: Int
    var hobby: String
    
    internal init(searchable: Int, ageMin: Int, ageMax: Int, gender: Int, hobby: String) {
        self.searchable = searchable
        self.ageMin = ageMin
        self.ageMax = ageMax
        self.gender = gender
        self.hobby = hobby
    }
}

