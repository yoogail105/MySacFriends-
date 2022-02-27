//
//  HomeText.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/02/10.
//

import Foundation

enum HobbyViewText: String {
    
    case findFriend = "새싹 찾기"
    case searchBarPlaceholder = "띄어쓰기로 복수 입력이 가능해요"
    case collectionViewHeader01 = "지금 주변에는"
    case collectionViewHeader02 = "내가 하고싶은"
    
    case changeHobby = "취미 변경하기"
    case emptyFriendsTitle = "아쉽게도 주변에 새싹이 없어요ㅠ"
    case emptyRequestTitle = "아직 받은 요청이 없어요ㅠ"
    case emptyPageSubtitle = "취미를 변경하거나 조금만 더 기다려 주세요!"
}


enum FindText: String {
    case nearByFriends = "주변 새싹"
    case receivedRequests = "받은 요청"
    case stopFinding = "찾기 중단"
}
