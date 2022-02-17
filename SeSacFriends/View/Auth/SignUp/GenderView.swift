//
//  GenderView.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/23.
//

import UIKit
import SnapKit


class GenderView: AuthView {
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    let button01: UIButton = {
        let button = UIButton()
        button.layer.borderColor = UIColor.grayColor(.gray3).cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 8
        return button
    }()
    
    let buttonImage01: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: AssetIcon.man.rawValue)
        return image
    }()
    
    let buttonTitle01: UILabel = {
        let label = UILabel()
        label.text = "남자"
        label.font = UIFont().Title2_R16
        return label
    }()
    
    
    let button00: UIButton = {
        let button = UIButton()
        button.layer.borderColor = UIColor.grayColor(.gray3).cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 8
        return button
    }()
    
    let buttonImage00: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: AssetIcon.woman.rawValue)
        return image
    }()
    
    let buttonTitle00: UILabel = {
        let label = UILabel()
        label.text = "여자"
        label.font = UIFont().Title2_R16
        return label
    }()
    
//    let genderButton01: GenderButton = {
//        let button = GenderButton()
//        button.buttonImage.image = UIImage(named: AssetIcon.man.rawValue)
//        button.buttonTitle.text = "남자"
//        return button
//    }()
//
//    let genderButton00: GenderButton = {
//        let button = GenderButton()
//        button.buttonImage.image = UIImage(named: AssetIcon.woman.rawValue)
//        button.buttonTitle.text = "여자"
//        return button
//    }()
    
    
    override func configuration() {
        
        mainLabel.text = SignUpText.setGender.rawValue
        subLabel.text = SignUpText.setGenderSub.rawValue
        
        textField.isHidden = true
        line.isHidden = true
        
        nextButton.setTitle(SignUpText.nextButton.rawValue, for: .normal)
        
    }
    
    override func constraints() {
        super.constraints()
        
        [stackView].forEach {
            addSubview($0)
        }
        
        [button01, button00].forEach {
            stackView.addArrangedSubview($0)
        }
        
        [buttonImage01, buttonTitle01].forEach {
            button01.addSubview($0)
        }
        
        [buttonImage00, buttonTitle00].forEach {
            button00.addSubview($0)
        }
     
        
        stackView.snp.makeConstraints {
         //  $0.height.equalTo(120)
            $0.bottom.equalTo(nextButton.snp.top).offset(-32)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        buttonImage01.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.width.equalTo(64)
            $0.top.equalToSuperview().offset(14)
        }
        
        buttonTitle01.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(buttonImage01.snp.bottom)
            $0.bottom.equalToSuperview().offset(-14)
        }
        
        buttonImage00.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.width.equalTo(64)
            $0.top.equalToSuperview().offset(14)
        }
        
        buttonTitle00.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(buttonImage00.snp.bottom)
            $0.bottom.equalToSuperview().offset(-14)
        }
        
    }
    
}
