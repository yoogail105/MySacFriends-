//
//  QueueRequest.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/02/12.
//

import Foundation

struct QueueRequest: Codable {
    var type: Int
    var region: Int
    var long: Double
    var lat: Double
    var hf: [String]
    
    init(type: Int, region: Int, long: Double, lat: Double, hf: [String]) {
        self.type = type
        self.region = region
        self.long = long
        self.lat = lat
        self.hf = hf
    }
}

struct OnQueueRequest: Codable {
    var region: Int
    var lat: Double
    var long: Double
    
    init(region: Int, lat: Double, long: Double) {
        self.region = region
        self.lat = lat
        self.long = long

    }
}
