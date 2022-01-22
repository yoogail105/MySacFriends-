//
//  NicknameView.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/23.
//
import UIKit


class NicknameView: BaseUIView{
    
    
    let mainLabel: UILabel = {
        let label = UILabel()
        label.text = SignUpText.setNickname.rawValue
        label.font = UIFont().Display1_R20
        return label
    }()
    
    let textField: UITextField = {
       let textField = UITextField()
        textField.placeholder = SignUpText.nicknamePlaceholder.rawValue
        textField.borderStyle = .none
        
        return textField
    }()
    
    
}
