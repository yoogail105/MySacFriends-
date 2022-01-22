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
//
//    func underLine() {
//        let border = CALayer()
//        border.frame = CGRect(x: 0, y: self.frame.size.height-1, width: self.frame.width, height: 1)
//        border.borderWidth = 1
//        border.borderColor = UIColor.grayColor(.gray3).cgColor
//
//    }
    
    let mainLabel: UILabel = {
        let label = UILabel()
        label.text = AuthText.mainLabel.rawValue
        label.numberOfLines = 0
        label.font = UIFont().Display1_R20
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    
    let numberTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = AuthText.phoneNumberPlaceholder.rawValue
        textField.keyboardType = .numberPad
        textField.textColor = .black
        //textField.borderStyle = .none
        
        return textField
    }()
 
    let line = UIView()
    
    let verifyButton: BaseButton = {
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
            mainLabel, numberTextField, line, verifyButton
        ].forEach {
            addSubview($0)
        }
        
        mainLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(numberTextField.snp.top).offset(-77)
            
        }
        
        verifyButton.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.centerY.equalToSuperview().offset(50)
        }
        
        
        numberTextField.snp.makeConstraints {
            $0.bottom.equalTo(verifyButton.snp.top).offset(-72)
            $0.leading.equalTo(verifyButton.snp.leading)
            $0.trailing.equalTo(verifyButton.snp.trailing)
            $0.height.equalTo(48)
        }
        
        line.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.leading.trailing.equalTo(numberTextField)
            $0.top.equalTo(numberTextField.snp.bottom).offset(1)
        }
    }
}


