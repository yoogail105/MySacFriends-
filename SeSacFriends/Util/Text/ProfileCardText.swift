//
//  ProfileDetailText.swift
//
//
//  Created by 성민주민주 on 2022/01/29.
//

import Foundation

enum ProfileDetailText: String {
    case gender = "내 성별"
    case hobby = "자주 하는 취미"
    case desiredHobby = "하고 싶은 취미"
    case hobbyPlaceholder = "취미를 입력해 주세요"
    case phoneNumber = "내 번호 검색 허용"
    case partnerAge = "상태방 연령대"
    case withdrawal = "회원탈퇴"
    case man = "남자"
    case woman = "여자"
    case sesacTtitle = "새싹 타이틀"
    case review = "새싹 리뷰"
    case reviewPlaceholder = "첫 리뷰를 기다리는 중이에요!"
    case request = "요청하기"
    
}

enum ProfileCardTableViewSectionHeaderText: String, CaseIterable {
    case section1 = "새싹 타이틀"
    case section2 = "새싹 리뷰"
}


