//
//  AuthVerificationCodeView.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/19.
//

import Foundation
import UIKit
import SnapKit

class AuthVerificationCodeView: UIView {
    
    let mainLabel: UILabel = {
        let label = UILabel()
        label.text = AuthVerificationCodeText.mainLabel.rawValue
        label.font = UIFont().Display1_R20
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    let subLabel: UILabel = {
       let label = UILabel()
        label.text = AuthVerificationCodeText.subLabel.rawValue
        label.textAlignment = .center
        label.font = UIFont().Title2_R16
        label.textColor = UIColor.grayColor(.gray7)
        return label
    }()
    
    let numberTextField: UITextField = {
       let textField = UITextField()
        textField.placeholder = AuthVerificationCodeText.codePlaceholder.rawValue
        textField.keyboardType = .numberPad
        textField.textColor = .black
        textField.borderStyle = .none
        return textField
    }()
      
    let timerLabel: UILabel = {
       let label = UILabel()
        label.text = "01:00"
        label.textColor = UIColor.brandColor(.green)
        label.font = UIFont().Title3_M14
        return label
    }()
    
    let reSendButton: BaseButton = {
        let button = BaseButton()
        button.buttonMode(.fill, title: AuthVerificationCodeText.resendButton.rawValue)
        button.titleLabel?.font = UIFont().Body3_R14
        return button
    }()
    
    
    let verifyButton: BaseButton = {
       let button = BaseButton()
        button.buttonMode(.disable, title: AuthVerificationCodeText.authVerificationCodeButton.rawValue)
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
        numberTextField.underLine()
    }
    
    func constraints() {
        [
            mainLabel, subLabel, timerLabel, numberTextField, reSendButton, verifyButton
        ].forEach {
            addSubview($0)
        }
        
        mainLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(numberTextField.snp.top).offset(-77)
            
        }
        
        subLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(mainLabel.snp.bottom).offset(-8)
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
        
        reSendButton.snp.makeConstraints {
            $0.leading.equalTo(numberTextField.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().offset(-16)
            $0.centerY.equalTo(numberTextField)
            $0.height.equalTo(40)
            $0.width.equalTo(72)
        }
        
        timerLabel.snp.makeConstraints {
            $0.trailing.equalTo(reSendButton.snp.leading).offset(-20)
            $0.centerY.equalTo(numberTextField)
        }
        
        
    }
}


