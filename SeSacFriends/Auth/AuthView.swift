//
//  AuthView.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/18.
//

import Foundation
import UIKit
import SnapKit

class AuthView: UIView {
    
    let mainLabel: UILabel = {
        let label = UILabel()
        label.text = AuthText.mainLabel.rawValue
        label.numberOfLines = 0
        label.font = UIFont().Display1_R20
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = AuthText.phoneNumberPlaceholder.rawValue
        textField.keyboardType = .numberPad
        textField.textColor = .black
        textField.autocorrectionType = .no
        
        return textField
    }()
 
    let line = UIView()
    
    let nextButton: BaseButton = {
        let button = BaseButton()
        button.buttonMode(.disable, title: AuthText.authButton.rawValue)
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configuration()
        constraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configuration() {
        self.backgroundColor = .white

    }
    
    func constraints() {
        [
            mainLabel, textField, line, nextButton
        ].forEach {
            addSubview($0)
        }
        
        mainLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(textField.snp.top).offset(-77)
            
        }
        
        nextButton.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.centerY.equalToSuperview().offset(50)
        }
        
        
        textField.snp.makeConstraints {
            $0.bottom.equalTo(nextButton.snp.top).offset(-72)
            $0.leading.equalTo(nextButton.snp.leading)
            $0.trailing.equalTo(nextButton.snp.trailing)
            $0.height.equalTo(48)
        }
        
        line.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.leading.trailing.equalTo(textField)
            $0.top.equalTo(textField.snp.bottom).offset(1)
        }
    }
}


