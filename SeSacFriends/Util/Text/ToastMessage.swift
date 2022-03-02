//
//  ToastMessage.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/21.
//

import Foundation

enum NetworkErrorMessage: String {
    case notConnected = "네트워크 연결이 원활하지 않습니다. 연결상태 확인 후 다시 시도해 주세요!"
}

enum notAcceptable: String {
    case notAcceptableUser = "오류가 발생했습니다.\n다시 로그인 해주세요."
}

enum requestVerificationCodeToast: String {
    case isValid = "전화 번호 인증 시작"
    case invalidPhoneFormat = "잘못된 전화번호 형식입니다."
    case invalidCodeForamt = "잘못된 인증번호 형식입니다."
    case overRequest = "과도한 인증시도가 있었습니다.\n나중에 다시 시도해 주세요."
    case unkownError = "에러가 발생했습니다.\n다시 시도해 주세요."
}

enum FirebaseAuthErrorCodeToast: String {
    case e17057 = "이미 전송되었습니다.\n 메세지함을 확인해 주세요."
    case e17993 = "오류오류 그놈의 오류임."
    case s17010 = "과도한 인증시도가 있었습니다.\n나중에 다시 시도해 주세요." //overRequest
}

enum SignUpToast: String {
    case nicknameCountError = "닉네임은 1자 이상 10자 이내로 부탁드려요."
    case invalidNickname = "해당 닉네임은 사용할 수 없습니다."
    case invalidBirth = "새싹친구는 만 17세 이상만 사용할 수 있습니다."
    case invalidEmail = "이메일 형식이 올바르지 않습니다."
}

enum RequestFriendToast: String {
    case created = "신고가 누적되어 이용하실 수 없습니다."
    case firstPenalty = "약속취소 페널티 1단계 적용 중 입니다."
    case secondPenalty = "약속취소 페널티 2단계 적용 중 입니다."
    case finalPenalty = "약속취소 페널티 3단계 적용 중 입니다"
    case emptyGender = "새싹을 찾기 위해서는 성별 입력이 필요합니다."
}

enum HomeViewToast: String {
    case genderError = "새싹 찾기 기능을 이용하기 위해서는 성별이 필요해요!"
}


enum AddMyHobbyToast: String {
    case lengthLimit = "최소 한 자 이상, 최대 8글자까지 작성 가능합니다"
    case existedHobby = "이미 등록된 취미입니다."
    case numberLimit = "취미는 8개를 넘을 수 없어요."
}

enum FindingToast: String {
    case alreadyMatched = "누군가와 취미를 함께하기로 약속하셨어요!"
}

enum TogetherToast: String {
    case requestSuccess = "취미 함께 하기 요청을 보냈습니다."
    case created = "상대방이 이미 다른 사람과 취미를 함께하는 중입니다."
    case invalidRequest = "상대방이 취미 함께 하기를 그만두었습니다."
    case alreadyMatched = "앗! 누군가가 나의 취미 함께 하기를 수락하였어요!"
}
