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

// user: 회원가입: 201이미가입유저, 202 사용못하는닉네임
//report 신고하기:

//queue: 201, 203, 204, 205, 206,
// hobbyRequest: 201, 202새싹찾기중단
// hobbyaccep: 201, 202상대방새싹찾기중단한상태, 203,
// myqueuestatse: 201
// rate: 리뷰작성: 
// dodge: 201 잘못된 otheruid 취미약속취소
//

//chat: 채팅내용요청 -> realm

enum APIErrorCode: Int, Error {
    case ok = 200
    case unAuthorized = 401 //firebase idtoken
    case notAcceptable = 406 // already deleted user. 미가입회원
    case internalServerError = 500
    case developerError = 501
    
    case networkError
    case verificationCodeError
    case failed
    case noData
    case invalidData
    
    case created = 201
    case invalidRequest = 202
    case firstPenalty = 203

    case secondPenalty = 204
    case finalPenalty = 205
    case emptyGender = 206
    
    case decodableError = 600
    case unKnownError = 700
    
}

enum APIErrorMessage: String, Error {
    case invalidResponse
    case noData
    case networkError = "네트워크 연결이 원활하지 않습니다. 연결상태 확인 후 다시 시도해 주세요!"
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
    case unKnownError = "알 수 없는 오류가 발생했습니다. 다시 시도해 주세요."

}
