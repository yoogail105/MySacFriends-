//
//  ToastMessage.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/21.
//

import Foundation

enum requestVerificationCode: String {
    case isValid = "전화 번호 인증 시작"
    case inValid = "잘못된 전화번호 형식 입니다."
    case overRequest
    
}
