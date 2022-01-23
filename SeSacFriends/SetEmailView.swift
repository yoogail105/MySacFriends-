//
//  EmailView.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/23.
//


class setEmailView: AuthView{
    
    override func configuration() {
        mainLabel.text = SignUpText.setEmail.rawValue
        subLabel.text = SignUpText.setEmailSub.rawValue
        
        textField.placeholder = SignUpText.emailPlaceholder.rawValue
        textField.keyboardType = .emailAddress
        
        nextButton.setTitle(SignUpText.nextButton.rawValue, for: .normal)
    }
}

