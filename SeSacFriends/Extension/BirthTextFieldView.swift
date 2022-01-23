//
//  BirthTextFieldView.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/24.
//


import UIKit
import SnapKit

class BirthTextFieldView: BaseUIView {

    
    let textFieldBox = UIView()
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont().Title4_R14
        textField.textAlignment = .left
        textField.textColor = UIColor.black
        textField.placeholder = "1990"
        //placeholder = gray7
        return textField
    }()
    
    
    let line = UIView()
    
    let label: UILabel = {
       let label = UILabel()
        label.font = UIFont().Title2_R16
        label.textColor = UIColor.black
        label.text = "년"
        return label
    }()
    
    override func configuration() {
        line.backgroundColor = UIColor.grayColor(.gray3)
    }
    override func constraints() {
        
        
        
        [textField, line, label].forEach {
            addSubview($0)
        }
        
        textField.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalTo(label.snp.leading).offset(-4)
            $0.width.equalTo(80)
        }
        
        line.snp.makeConstraints {
            
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalTo(textField)
            $0.height.equalTo(1)
        }
        
        label.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview()
        }

        
    }
}
