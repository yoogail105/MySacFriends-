//
//  ToastMessage.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/21.
//

import Foundation

enum requestVerificationCode: String {
    case isValid = "전화 번호 인증 시작"
    case invalid = "잘못된 전화번호 형식입니다."
    case overRequest = "과도한 인증시도가 있었습니다.\n나중에 다시 시도해 주세요."
    case unkownError = "에러가 발생했습니다.\n다시 시도해 주세요."
    
}

enum FirebaseAuthErrorCode: String {
    case e17057 = "이미 전송되었습니다.\n 메세지함을 확인해 주세요."
    case e17993 = "오류오류 그놈의 오류임."
}

/*
enum HTTPCode: Int {
        case OK = 200
        case NOT_MODIFY = 304
        case SERVER_ERROR = 500

        var value: String {
                return "HTTP number is \(self.rawValue)"
        }

        func getDescription () -> String {
                switch self {
                case .OK :
                        return "HTTP 코드는 \(self.rawValue)" 입니다
                }
                ....
        }
        
        static func getName() -> String {
                return "이건 ~~"
        }
}
*/
