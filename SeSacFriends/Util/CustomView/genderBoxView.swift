//
//  genderBoxView.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/24.
//

import UIKit
import SnapKit

class GenderButton: UIButton {
    
    let button: UIButton = {
        let button = UIButton()
        button.layer.borderColor = UIColor.grayColor(.gray3).cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 8
        return button
    }()
    
    let buttonImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: AssetIcon.woman.rawValue)
        return image
    }()
    
    let buttonTitle: UILabel = {
        let label = UILabel()
        label.text = "여자"
        label.font = UIFont().Title2_R16
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        constraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func constraints() {
        addSubview(button)
        [buttonImage, buttonTitle].forEach {
            button.addSubview($0)
        }
        
        buttonImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.width.equalTo(64)
            $0.top.equalToSuperview().offset(14)
        }
        
        buttonTitle.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(buttonImage.snp.bottom)
            $0.bottom.equalToSuperview().offset(-14)
        }
    }
    
}
