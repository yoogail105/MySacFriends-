//
//  UserRequest.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/02/12.
//

import Foundation

struct SignUpRequest: Codable {
    var phoneNumber: String
    var FCMtoken: String
    var nick: String
    var birth: String
    var email: String
    var gender: Int
    
    internal init(phoneNumber: String, FCMtoken: String, nick: String, birth: String, email: String, gender: Int) {
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

