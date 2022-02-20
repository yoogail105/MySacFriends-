//
//  EmailView.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/23.
//
import UIKit

class setEmailView: AuthView{
    
    override func configuration() {
        mainLabel.text = SignUpText.setEmail.rawValue
        subLabel.text = SignUpText.setEmailSub.rawValue
        textField.keyboardType = .emailAddress
        textField.becomeFirstResponder()
        
        if UserDefaults.standard.email != "" {
            textField.text = UserDefaults.standard.email
        } else {
            textField.placeholder = SignUpText.emailPlaceholder.rawValue
        }
        
        nextButton.setTitle(SignUpText.nextButton.rawValue, for: .normal)
    }
}

