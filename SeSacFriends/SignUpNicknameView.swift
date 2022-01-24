//
//  SignUpNicknameView.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/22.
//

import UIKit

class SignUpNicknameView: BaseUIView {
    
    
    let mainLabel: UILabel = {
        let label = UILabel()
        label.text = SignUpText.setNickname.rawValue
        return label
    }()

}
