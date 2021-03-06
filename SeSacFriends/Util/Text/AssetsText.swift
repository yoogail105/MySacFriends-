//
//  AssetIcon.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/23.
//

import Foundation

enum AssetIcon: String {
    case send
    case backArrow = "arrow"
    case antenna
    case bell
    case cancelMatch = "cancel_match"
    case check
    case closeBig = "close_big"
    case closeSmall = "close_small"
    case closeSmallGreen = "close_small_green"
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
    case refresh = "refresh"
    case sesacBlack
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
    case face = "sesac_face_"
    case face0 = "sesac_face_0"
    case face1 = "sesac_face_1"
    case face2 = "Oesac_face_2"
    case face3 = "sesac_face_3"
    case face4 = "sesac_face_4"
    
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
    case back = "sesac_background_"
    case back0 = "sesac_background_0"
    case back1 = "sesac_background_1"
    case back2 = "sesac_background_2"
    case back3 = "sesac_background_3"
    case back4 = "sesac_background_4"
    case back5 = "sesac_background_5"
    case back6 = "sesac_background_6"
    case back7 = "sesac_background_7"
    case back8 = "sesac_background_8"
}

enum homeIcon: String {
    case search
    case finding
    case message
    case marker = "map_marker"
}
