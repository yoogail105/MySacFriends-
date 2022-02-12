//
//  User.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/24.
//

import Foundation

struct  User: Codable {
    let uid: String
    let phoneNumber: String
    let FCMtoken: String
    let nick: String
    let birth: String
    let gender: Int
    let email: String
    var hobby: String
    let comment: Array<String>
    let reputation: Array<Int>
    let sesac: Int
    let sesacCollection: Array<Int>
    let background: Int
    let backgroundCollection: Array<Int>
    let purchaseToken: Array<String>
    let transactionId: Array<String>
    let reviewedBefore: Array<String>
    let reportedNum: Int
    let reportedUser: Array<String>
    let dodgepenalty: Int
    let dodgeNum: Int
    var ageMin: Int
    var ageMax: Int
    var searchable: Int
    let createdAt: String
}
