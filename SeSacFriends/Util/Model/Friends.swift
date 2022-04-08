//
//  Friends.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/02/10.
//

import Foundation


struct Friends: Codable {
    let fromQueueDB, fromQueueDBRequested: [Friend]
    let fromRecommend: [String]
}

struct Friend: Codable {
    let uid, nick: String
    let lat, long: Double
    let reputation: [Int]
    let hf, reviews: [String]
    var gender, type, sesac, background: Int
    //sesac: 새싹이미지
}
