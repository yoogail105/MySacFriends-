//
//  ChatView.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/03/16.
//

import Foundation
import UIKit
import Then
import SnapKit

class ChatView: BaseUIView {
    let dateLabel = UILabel().then {
        $0.text = "1월 15일 토요일"
        $0.font = UIFont().Title5_M12
        $0.textColor = .white
    }
    
    let matchingIcon = UIImageView().then {
        $0.image = UIImage(systemName: "bell")
        $0.tintColor = UIColor.grayColor(.gray7)
    }
        
    let matchingLabel = UILabel().then {
        $0.text = "고래밥님과 매칭되었습니다"
        $0.font = UIFont().Title3_M14
        $0.textColor = UIColor.grayColor(.gray7)
    }
    
    let matchingSubLabel = UILabel().then {
        $0.text = "채팅을 통해 약속을 정해보세요 :)"
        $0.font = UIFont().Title4_R14
        $0.textColor = UIColor.grayColor(.gray6)
    }
    
    let writeTextField = UITextField().then {
        $0.placeholder = "메세지를 입력하세요"
        $0.textColor = UIColor.grayColor(.gray7)
        $0.font = UIFont().Body3_R14
    }
    
    let sendButton = UIButton().then {
        $0.setImage(UIImage(named: AssetIcon.send.rawValue), for: .normal)
    }
    
    override func addViews() {
        [dateLabel, matchingIcon, matchingSubLabel, writeTextField, sendButton].forEach {
            addSubview($0)
        }
    }
    
    override func constraints() {
        self.backgroundColor = UIColor.brandColor(.yellowgreen)
    }
}
