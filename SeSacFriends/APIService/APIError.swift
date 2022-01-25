//
//  APIError.swift
//  
//
//  Created by 성민주민주 on 2022/01/25.
//

import Foundation

enum APIError: String, Error {
    case invalidResponse
    case noData
    case failed = "에러가 발생했습니다. 다시 시도해주세요."
    case invalidData
    case unAuthorized = "확인되지 않은 사용자입니다." //201
    case already = "이미 가입한 계정입니다."//202 이미 가입 -> 홈호면 already
    case invalidNickname  = "사용할 수 없는 닉네임입니다."//202
    case expiredIDToken = "파이어 베이스 토큰 에러"// 401
    case serverError = "ServerError" //500
    case clientError = "ClientError" //501
    case tooManyRequests = "과도한 인증 시도가 있었습니다. 나중에 다시 시도해 주세요."
    case verificaitonToken = "인증번호가 일치하지 않습니다."

}


enum StatusCode: String {
    case E201 = "이미 가입한 계정입니다."
    case E202 = "사용할 수 없는 닉네임입니다."
    case E401 = "파이어 베이스 토큰 에러"
    case E500 = "ServerError"
    case E501 = "ClientError"
}
