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
        label.text = "새싹 서비스 이용을 위해\n 휴대폰 번호를 입력해 주세요."
        label.numberOfLines = 0
        label.font = UIFont(name: AppFont.regular.rawValue, size: 20)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    let numberTextField: UITextField = {
       let textField = UITextField()
        textField.placeholder = "휴대폰 번호(-없이 숫자만 입력)"
        textField.keyboardType = .numberPad
        textField.textColor = .black
        textField.borderStyle = .none
        
        return textField
    }()
    
    let verifyButton: UIButton = {
       let button = UIButton()
        button.setTitle("인증 문자 받기", for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor.grayColor(.gray6)
        button.layer.cornerRadius = 10
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


