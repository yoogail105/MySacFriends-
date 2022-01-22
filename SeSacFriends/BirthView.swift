//
//  BirthView.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/23.
//

import UIKit


class BirthView: AuthView{
    
    override func configuration() {
        mainLabel.text = SignUpText.setBirthday.rawValue
        nextButton.setTitle(SignUpText.nextButton.rawValue, for: .normal)
        
        //pickerview
    }
}
