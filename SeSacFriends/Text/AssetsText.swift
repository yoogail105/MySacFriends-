//
//  AssetIcon.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/23.
//

import Foundation

enum AssetIcon: String {
    case backArrow = "arrow"
    case antenna
    case bell
    case cancelMatch = "cancel_match"
    case check
    case closeBig = "close_big"
    case closeSmall = "close_small"
    case filterControl = "filter_control"
    case friendsPlus = "friends_plus"
    case man
    case message
    case moreArrow = "more_arrow_right"
    case moreArrowUp = "more_arrow_up"
    case moreArrowDown = "more_arrow_down"
    case more
    case place
    case plus
    case search
    case sirencase
    case woman
    case write
    case bagde
    case sesacImg
    case profileIcon = "profile_img"
}

enum TabBarIcon: String {
    case friendsAct
    case friendsInact
    case homeAct
    case homeInact
    case myAct
    case myInact
    case sendAct
    case sendInact
    case shopAct
    case shopInact
}

enum SesacIcon: String, CaseIterable {
    case face1 = "sesac_face_1"
    case face2 = "sesac_face_2"
    case face3 = "Oesac_face_3"
    case face4 = "sesac_face_4"
    case face5 = "sesac_face_5"
    
}

enum myPageMenuIcon: String, CaseIterable {
    case notice
    case question = "faq"
    case qna
    case settingAlarm = "setting_alarm"
    case permit
}

enum BackgroundImage: String {
    case black = "sesac_bg_black"
    case color = "sesac_bg_color"
}