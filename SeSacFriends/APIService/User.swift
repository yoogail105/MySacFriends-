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
    var FCMToken: String
    var nick: String
    var birth: String
    var gender: Int
    var email: String
    var hobby: String
    var comment: Array<String>
    var reputation: Array<Int>
    var sesac: Int
    var sesacCollection: Array<String>
    var background: Int
    var backgroundCollection: Array<Int>
    var purchaseToken: Array<String>
    var transactionId: Array<String>
    var reviewedBefore: Array<String>
    var reportedNum: Int
    var reportedUser: Array<String>
    var dodgepenalty: Int
    var dodgeNum: Int
    var ageMin: Int
    var ageMax: Int
    var searchable: Int
    var createdAt: Date
}
