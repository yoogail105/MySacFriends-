//
//  ReceivedView.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/03/02.
//

import UIKit


class ReceivedView: BaseUIView {
    
    let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 10
        $0.alignment = .fill
        $0.distribution = .equalSpacing
    }
    
    let sesacBlackImage = UIImageView().then {
        $0.image = UIImage(named: AssetIcon.sesacBlack.rawValue)
    }
    
    let emptyFriendsTitle = UILabel().then {
        $0.text = HobbyViewText.emptyRequestTitle.rawValue
        $0.font = UIFont().Display1_R20
        $0.textColor = .black
    }
    
    let emptyFriendsSubtitle = UILabel().then {
        $0.text = HobbyViewText.emptyPageSubtitle.rawValue
        $0.font = UIFont().Title4_R14
        $0.textColor = UIColor.grayColor(.gray7)
    }
    

    override func constraints() {
        
        [sesacBlackImage, emptyFriendsTitle, emptyFriendsSubtitle].forEach {
            addSubview($0)
        }
        
        
        emptyFriendsTitle.snp.makeConstraints {
            $0.centerY.centerX.equalToSuperview()
        
        }
        
        emptyFriendsSubtitle.snp.makeConstraints {
            $0.top.equalTo(emptyFriendsTitle.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
            
        }
        
        sesacBlackImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(emptyFriendsTitle.snp.top).offset(-32)
            $0.width.height.equalTo(64)
        }
    }
    
}
