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
    let dateLabelView = UIView().then {
        $0.backgroundColor = UIColor.grayColor(.gray7)
        $0.layer.cornerRadius = 13.5
    }
    
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
    
    let stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 0
        $0.alignment = .fill
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
        [dateLabelView, stackView, matchingSubLabel, writeTextField, sendButton].forEach {
            addSubview($0)
        }
        
        dateLabelView.addSubview(dateLabel)
        
        [matchingIcon, matchingLabel].forEach {
            stackView.addArrangedSubview($0)
        }
    }
    
    override func constraints() {
        self.backgroundColor = .white
        
        dateLabelView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(16)
            $0.width.equalTo(114)
            $0.height.equalTo(28)
        }
        
        dateLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        
        stackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(dateLabel.snp.bottom).offset(12)
        }
        
        matchingSubLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(stackView.snp.bottom)
        }
        
    }
}
