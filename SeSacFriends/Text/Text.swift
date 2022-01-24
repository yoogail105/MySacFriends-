//
//  Text.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/22.
//

import Foundation




enum AuthText: String {
    case mainLabel = "새싹 서비스 이용을 위해\n 휴대폰 번호를 입력해 주세요."
    case authButton = "인증 번호 받기"
    case phoneNumberPlaceholder = "휴대폰 번호(-없이 숫자만 입력)"
}

enum AuthVerificationCodeText: String {
    case mainLabel = "인증번호가 문자로 전송되었어요."
    case subLabel = "최대 소모 20초"
    case codePlaceholder = "인증번호 입력"
    case resendButton = "재전송"
    case authVerificationCodeButton = "인증하고 시작하기"
}


enum SignUpText: String {
    case nextButton = "다음"
    case setNickname = "닉네임을 입력해 주세요"
    case setBirthday = "생년월일을 알려주세요"
    case setEmail = "이메일을 입력해 주세요"
    case setEmailSub = "휴대폰 번호 변경 시 인증을 위해 사용해요"
    case setGender = "성별을 선택해 주세요"
    case setGenderSub = "새싹 찾기 기능을 이용하기 위해서 필요해요!"
    case nicknamePlaceholder = "10자 이내로 입력"
    case emailPlaceholder = "SeSAC@email.com"

}

