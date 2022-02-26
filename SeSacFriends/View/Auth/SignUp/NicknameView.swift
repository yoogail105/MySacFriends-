//
//  NicknameView.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/23.
//
import UIKit


class NicknameView: AuthView{
    
    override func configuration() {
        mainLabel.text = SignUpText.setNickname.rawValue
        
        
        if UserDefaults.standard.nickname != "" {
            textField.text = UserDefaults.standard.nickname
        } else {
            textField.placeholder = SignUpText.nicknamePlaceholder.rawValue
        }
        subLabel.isHidden = true
        textField.keyboardType = .default
        
        nextButton.setTitle(SignUpText.nextButton.rawValue, for: .normal)
    }
}
