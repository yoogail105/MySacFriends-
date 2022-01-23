//
//  GenderView.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/23.
//

import UIKit
import SnapKit


class GenderView: AuthView {
    
    let genderImage01: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: AssetIcon.man.rawValue)
        return imageView
    }()
    let genderImage02: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: AssetIcon.woman.rawValue)
        return imageView
    }()
    
    override func configuration() {
        
        mainLabel.text = SignUpText.setGender.rawValue
        subLabel.text = SignUpText.setGenderSub.rawValue
        
        textField.isHidden = true
        line.isHidden = true
        
       
        
        nextButton.setTitle(SignUpText.nextButton.rawValue, for: .normal)
        
    }
    
    override func constraints() {
        
        [genderImage01, genderImage02].forEach {
            addSubview($0)
        }
        
        genderImage01.snp.makeConstraints {
            
            $0.top.equalTo(nextButton.snp.top)
        }
        
        
    }
    
}
