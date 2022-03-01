//
//  ProfileHeaderView.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/31.
//  새싹 이미지 카드 뷰

import UIKit

import CoreText
class ProfileHeaderView: BaseUIView {
    var backgroundImage = UIImageView().then {
        $0.image = UIImage(named: BackgroundImage.color.rawValue)
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
    }
    
    var userImage = UIImageView().then {
        $0.image = UIImage(named: SesacIcon.face1.rawValue)
    }
    
    
    
    override func constraints() {
        addSubview(backgroundImage)
        addSubview(userImage)
        
        
        backgroundImage.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        
        userImage.snp.makeConstraints {
            $0.centerX.equalTo(backgroundImage.snp.centerX)
            $0.bottom.equalTo(backgroundImage.snp.bottom)
            $0.width.equalTo(backgroundImage.snp.width).multipliedBy(0.5)
            $0.height.equalTo(self.snp.height)
        }
        
    }
    

}
