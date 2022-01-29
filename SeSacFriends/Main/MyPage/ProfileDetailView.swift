//
//  ProfileDetailView.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/28.
//

import UIKit
import SnapKit
import Then


class ProfileDetailView: BaseUIView {
    
    let profileTableView = UITableView().then {
        $0.backgroundColor = .yellow
    }
    
    let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 16
        $0.alignment = .fill
        $0.distribution = .equalSpacing
    }
    
    let genderView = UIView()
    let hobbyView = UIView()
    let phoneNumberView = UIView()
    let ageView = UIView()
    let withdrawalView = UIView()
    
    let backgroundImage = UIImageView().then {
        $0.image = UIImage(named: BackgroundImage.color.rawValue)
    }
    
    let userImage = UIImageView().then {
        $0.image = UIImage(named: SesacIcon.face1.rawValue)
    }
    
    let genderLabel = UILabel().then {
        $0.text = ProfileDetailText.gender.rawValue
        $0.font = UIFont().Body4_R12
    }
    
    let genderStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.alignment = .fill
        $0.distribution = .equalSpacing
        $0.backgroundColor = .yellow
    }
    
    let manButton = genderButton().then {
        $0.buttonMode(.inactive, title: ProfileDetailText.man.rawValue)
        
    }
    
    let womanButton = genderButton().then {
        $0.buttonMode(.inactive, title: ProfileDetailText.woman.rawValue)
    }
    
    let hobbyLabel = UILabel().then {
        $0.text = ProfileDetailText.hobby.rawValue
        $0.font = UIFont().Body4_R12
    }
    
    let hobbyTextField = UITextField().then {
        $0.placeholder = ProfileDetailText.hobbyPlaceholder.rawValue
        $0.font = UIFont().Title4_R14
    }
    
    let underLine = UIView().then {
        $0.backgroundColor = UIColor.grayColor(.gray3)
    }
    
    let phoneNumberPermissionLabel = UILabel().then {
        $0.text = ProfileDetailText.phoneNumber.rawValue
        $0.font = UIFont().Body4_R12
    }
     
    let phoneNumberPermissionToggle = UISwitch().then {
        $0.isOn = true
    }
    
    
    let ageLabel = UILabel().then {
        $0.text = ProfileDetailText.partnerAge.rawValue
        $0.font = UIFont().Body4_R12
    }
    
    let ageLabelSub = UILabel().then {
        $0.text = "18-35"
        $0.font = UIFont().Title3_M14
    }
    
    let ageBar = UISlider().then {
        $0.setThumbImage(UIImage(named: AssetIcon.filterControl.rawValue), for: .normal)
        $0.setMinimumTrackImage(UIImage(named: AssetIcon.filterControl.rawValue), for: .selected)
//        $0.minimumValueImage = UIImage(named: AssetIcon.filterControl.rawValue)
        $0.minimumTrackTintColor = UIColor.brandColor(.green)
        $0.maximumTrackTintColor =  UIColor.grayColor(.gray2)
        $0.maximumValue = 35
        $0.minimumValue = 18
    }
    
    let withdrawalLabel = UILabel().then {
        $0.text = ProfileDetailText.withdrawal.rawValue
        $0.font = UIFont().Body4_R12
    }
    
    override func constraints() {
        backgroundImage.addSubview(userImage)
        
        
        [stackView].forEach {
            
            addSubview($0)
        }
        
        
        [genderView, hobbyView, phoneNumberView, ageView, ageBar,  withdrawalView].forEach {
            stackView.addArrangedSubview($0)
        }
        
        [manButton, womanButton].forEach {
            genderStackView.addArrangedSubview($0)
        }
        
        [genderLabel, genderStackView].forEach {
            genderView.addSubview($0)
        }
        
        [hobbyLabel, hobbyTextField, underLine].forEach {
            hobbyView.addSubview($0)
        }
        
       
        
        [phoneNumberPermissionLabel, phoneNumberPermissionToggle].forEach {
            phoneNumberView.addSubview($0)
        }
        
        [ageLabel, ageLabelSub].forEach {
            ageView.addSubview($0)
        }
        
        
        [withdrawalLabel].forEach {
            withdrawalView.addSubview($0)
        }
        
        
        
        
//        profileTableView.snp.makeConstraints {
//            $0.height.equalTo(150)
//            $0.top.equalToSuperview().offset(16)
//        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        genderView.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        
        hobbyView.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        
        phoneNumberView.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        
        ageView.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        
        withdrawalView.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        
        genderLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        genderStackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        hobbyLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        
        hobbyTextField.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.centerX.equalTo(underLine.snp.centerX)
        }
        
        underLine.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.top.equalTo(hobbyTextField.snp.bottom).offset(12)
            $0.height.equalTo(1)
            $0.width.equalTo(164)
        }
        
        phoneNumberPermissionLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        
        phoneNumberPermissionToggle.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        ageLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        
        ageLabelSub.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        ageBar.snp.makeConstraints {
            $0.height.equalTo(24)
            $0.leading.equalToSuperview().offset(12)
            $0.trailing.equalToSuperview().offset(-12)
        }
        
        withdrawalLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
        }
    }
    
    
}
