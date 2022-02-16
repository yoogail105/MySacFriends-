//
//  AlertText.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/02/07.
//

import Foundation

enum AlertText: String {
    case withdrawalTitle = "정말 탈퇴하시겠습니까?"
    case withdrawalSubtitle = "탈퇴하시면 새싹 프렌즈를 이용할 수 없어요ㅠ"
    
    case acceptTogetherTitle = "취미 같이 하기를 수락할까요?"
    case acceptTogetherSubtitle = "요청을 수락하면 채팅창에서 대화를 나눌 수 있어요"
    
    case cancelTogetherTitle = "약속을 취소하겠습니까?"
    case cancelTogetherSubtitle = "약속을 취소하시면 패널티가 부과됩니다"
    
    case addFriendTitle = "고래밥님을 친구 목록에 추가할까요?"
    case addFriendSubtitle = "친구 목록에 추가하면 언제든지 채팅을 할 수 있어요"
    
    case logoutTitle = "정말 로그아웃 하시겠습니까?"

    case requestLocationPermissionTitle = "위치 서비스를 사용할 수 없습니다."
    case requestLocationPermissionSubtitle = "현재 위치를 기반으로 주변에 있는 새싹 친구들을 검색하고, 취미를 공유하기 위해서 위치 정보에 대한 접근 허용이 필요합니다."
    case moveToSetting = "설정으로 이동"

}


