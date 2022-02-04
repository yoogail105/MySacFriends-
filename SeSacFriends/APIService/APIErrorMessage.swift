//
//  APIError.swift
//
//
//  Created by 성민주민주 on 2022/01/25.
//

import Foundation

/*
공통적으로 떨어지는 상태코드 200, 401, ...
200번이 뜨는 상태를 명시하고, 200을 401
그럼에도 안묶이는 것들에 대해서는 개별적으로 처리를 한다.
*/

enum APIErrorCode: Int, Error {
    case failed
    case noData
    case invalidData
    case ok = 200
    //case created = 201 // already existed user
    case invalidNickname = 202
    case firstPenalty = 203
    case secondPenalty = 204
    case finalPenalty = 205
    case emptyGender = 206
    case unAuthorized = 401 //firebase idtoken
    case internalServerError = 405
    case notAcceptable = 406 // already deleted user. 미가입회원
}

enum APIErrorMessage: String, Error {
    case invalidResponse
    case noData
    case failed = "에러가 발생했습니다. 다시 시도해주세요."
    case invalidData
    case unAuthorized = "확인되지 않은 사용자입니다." //406
    case alreadyExisted = "이미 가입한 계정입니다."//202 이미 가입 -> 홈호면 already
    case invalidNickname  = "사용할 수 없는 닉네임입니다."//202
    case expiredIDToken = "파이어 베이스 토큰 에러"// 401
    case serverError = "ServerError" //500
    case clientError = "ClientError" //501
    case tooManyRequests = "과도한 인증 시도가 있었습니다. 나중에 다시 시도해 주세요."
    case verificationTokenNotMatched = "인증번호가 일치하지 않습니다."
    case deletedUser = "이미 탈퇴한 회원입니다."

}


enum StatusCode: String {
    case E201 = "이미 가입한 계정입니다."
    case E202 = "사용할 수 없는 닉네임입니다."
    case E401 = "파이어 베이스 토큰 에러"
    case E500 = "ServerError"
    case E501 = "ClientError"
}
