//
//  GeneralAPIComponents.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/02/12.
//

import Foundation

struct GeneralAPIComponents {
        static let baseURL = "http://test.monocoding.com:35484"
        static let idToken = UserDefaults.standard.idToken!
        static let ContentType = "application/x-www-form-urlencoded"
    }

enum APIHeader: String {
    case idtoken
    case ContentType = "Content-Type"
}
