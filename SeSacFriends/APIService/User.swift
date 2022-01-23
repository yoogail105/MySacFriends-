//
//  User.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/24.
//

import Foundation

struct  User: Codable {
    var uid: String
    var phoneNumber: String
    var FCMtoken: String
    var nick: String
    var birth: String
    var gender: Int
}
