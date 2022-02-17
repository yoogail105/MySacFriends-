//
//  AlertView.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/02/05.
//

import UIKit
import SnapKit
import Then


class AlertView: BaseUIView {
    
    let background = UIView().then {
        $0.backgroundColor = .black
        $0.alpha = 0.3
    }
    
    let alertBackground = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 16
    }
    
    let titleStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 0
        $0.alignment = .center
        $0.distribution = .equalSpacing
    }
    
    var title = UILabel().then {
        $0.text = "약속을 취소하시겠습니까?"
        $0.font = UIFont().Body1_M16
        $0.textColor = .black
        $0.numberOfLines = 0
    }
    
    var subTitle = UILabel().then {
        $0.text = "약속을 취소하시면 패널티가 부과됩니다"
        $0.font = UIFont().Title4_R14
        $0.textColor = .black
        $0.numberOfLines = 0
        $0.textAlignment = .center
        
    }
    
    let buttonStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.alignment = .fill
        $0.distribution = .equalSpacing
    }
    
    let cancelButton = BaseButton().then {
        $0.buttonMode(.cancel, title: "취소")
    }
    
    let okButton = BaseButton().then {
        $0.buttonMode(.fill, title: "확인")
    }
    
    
    override func constraints() {
        [background, alertBackground].forEach {
            addSubview($0)
        }
        
        [titleStackView, buttonStackView].forEach {
            alertBackground.addSubview($0)
        }
        
        [title, subTitle].forEach {
            titleStackView.addArrangedSubview($0)
        }
        
        [cancelButton, okButton].forEach {
            buttonStackView.addArrangedSubview($0)
        }

        
        background.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        titleStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16.5)
            $0.trailing.equalToSuperview().offset(-16)
            $0.top.equalToSuperview().offset(16)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(titleStackView.snp.bottom).offset(16)
            $0.leading.trailing.equalTo(titleStackView)
            $0.height.equalTo(48)
        }
        
        okButton.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.48)
        }
        
        cancelButton.snp.makeConstraints {
            $0.width.equalTo(okButton.snp.width)
        }
        
        
        alertBackground.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.top.equalTo(titleStackView.snp.top).offset(-16)
            $0.bottom.equalTo(buttonStackView.snp.bottom).offset(16)
        }
        
        
    }
    
}
