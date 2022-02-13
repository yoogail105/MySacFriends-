//
//  MainView.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/26.
//


import UIKit
import SnapKit

class MainView: BaseUIView {
    
    
    let button: UIButton = {
        let button = UIButton()
        button.setTitle("탈퇴하기", for: .normal)
        button.tintColor = UIColor.black
        button.backgroundColor = .yellow
        return button
    }()
    
    override func constraints() {
        addSubview(button)
        
        button.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            
        }
    }
}
