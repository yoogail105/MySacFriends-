//
//  Friends.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/02/10.
//

import Foundation


struct Friends: Codable {
    let fromQueueDB, fromQueueDBRequested: [FromQueueDB]
    let fromRecommend: [String]
}

struct FromQueueDB: Codable {
    let uid, nick: String
    let lat, long: Double
    let reputation: [Int]
    let hf, reviews: [String]
    let gender, type, sesac, background: Int
    //sesac: 새싹이미지
}

/*
 
 {
     "fromQueueDB": [{
         "uid": "x4r4tjQZ8Pf9mFYUgkfmC4REcvu2",
         "nick": "미묘한고래",
         "lat": 37.48511640269022,
         "long": 126.92947109241517,
         "reputation": [0, 0, 0, 0, 0, 0, 0, 0, 0],
         "hf": ["anything", "coding"],
         "reviews": ["친절해요", "재밌어요"],
         "gender": 0,
         "type": 2,
         "sesac": 0, //새싹이미지
         "background": 0
     }],
     "fromQueueDBRequested": [{
         "uid": "x4r4tjQZ8Pf9mFYUgkfmC4REcvu2",
         "nick": "커피의나라",
         "lat": 37.48511640269022,
         "long": 126.92947109241517,
         "reputation": [4, 4, 4, 4, 4, 4, 4, 4, 4],
         "hf": ["anything", "coding"],
         "reviews": ["재밌어요", "약속을 잘지켜요"],
         "gender": 0,
         "type": 2,
         "sesac": 0,
         "background": 0
     }],
     "fromRecommend": ["요가", "독서모임", "SeSAC", "코딩"]
 }
 */
