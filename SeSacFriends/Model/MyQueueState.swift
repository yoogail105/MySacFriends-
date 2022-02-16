//
//  MyQueueState.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/02/16.
//

import Foundation

struct MyQueueState: Codable {
    let dodged, matched, reviewed: Int
    let matchedNick, matchedUid: String?
}
