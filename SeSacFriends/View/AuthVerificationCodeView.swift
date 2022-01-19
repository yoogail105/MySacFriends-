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
        label.text = "인증번호가 문자로 전송되었어요."
        label.font = UIFont().Display1_R20
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    let subLabel: UILabel = {
       let label = UILabel()
        label.text = "최대 소모 20초"
        label.textAlignment = .center
        label.font = UIFont().Title2_R16
        return label
    }()
    
    let numberTextField: UITextField = {
       let textField = UITextField()
        textField.placeholder = "인증번호 입력"
        textField.keyboardType = .numberPad
        textField.textColor = .black
        textField.borderStyle = .none
        return textField
    }()
    
    let reSendButton: BaseButton = {
        let button = BaseButton()
        button.buttonMode(.fill, title: "재전송")
        return button
    }()
    
    let verifyButton: BaseButton = {
       let button = BaseButton()
        button.buttonMode(.disable, title: "인증하고 시작하기")
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
       // numberTextField.underLine()
    }
    
    func constraints() {
        [
            mainLabel, numberTextField, verifyButton
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
        
        
    }
}


