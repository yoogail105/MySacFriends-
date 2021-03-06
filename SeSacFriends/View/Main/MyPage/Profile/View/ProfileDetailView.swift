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
    
    let viewModel = ProfileViewModel()
    
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
    let withdrawalButton = UIButton()
    
    let backgroundImage = UIImageView().then {
        $0.image = UIImage(named: BackgroundImage.back0.rawValue)
    }
    
    let userImage = UIImageView().then {
        $0.image = UIImage(named: SesacIcon.face1.rawValue)
    }
    
    let genderLabel = UILabel().then {
        $0.text = ProfileDetailText.gender.rawValue
        $0.font = UIFont().Body4_R12
    }
    var manButtonMode = CustomButton.inactive
    var womanButtonMode = CustomButton.inactive
    
    let manButton = BaseButton().then {
        $0.buttonMode(.inactive, title: ProfileDetailText.man.rawValue)
    }
    
    let womanButton = BaseButton().then {
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
     
    var searchableSwitch = UISwitch().then {
        $0.isOn = true
    }
    
    
    var ageLabel = UILabel().then {
        $0.text = ProfileDetailText.partnerAge.rawValue
        $0.font = UIFont().Body4_R12
        
    }

    
    let ageLabelSub = UILabel().then {
        $0.text = "18-35"
        $0.font = UIFont().Title3_M14
        $0.textColor = UIColor.brandColor(.green)
    }
    

    let ageBar = RangeSlider(frame: .zero).then {
        $0.clipsToBounds = false
    }

    let withdrawalLabel = UILabel().then {
        $0.text = ProfileDetailText.withdrawal.rawValue
        $0.font = UIFont().Body4_R12
    }
    
    override func configuration() {
       
        stackView.backgroundColor = .white
    }
    
    override func constraints() {
        
        addSubview(stackView)

       
    
        [genderView, hobbyView, phoneNumberView, ageView, ageBar,  withdrawalButton].forEach {
            stackView.addArrangedSubview($0)
        }

        [genderLabel, manButton, womanButton].forEach {
            genderView.addSubview($0)
        }

        [hobbyLabel, hobbyTextField, underLine].forEach {
            hobbyView.addSubview($0)
        }



        [phoneNumberPermissionLabel, searchableSwitch].forEach {
            phoneNumberView.addSubview($0)
        }

        [ageLabel, ageLabelSub].forEach {
            ageView.addSubview($0)
        }

        [withdrawalLabel].forEach {
            withdrawalButton.addSubview($0)
        }


        // MARK: Constraints
    

        stackView.snp.makeConstraints {
            $0.top.equalToSuperview()
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

        withdrawalButton.snp.makeConstraints {
            $0.height.equalTo(48)
        }

        genderLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
        }

        manButton.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.width.equalTo(56)
            $0.trailing.equalTo(womanButton.snp.leading).offset(-8)
            $0.centerY.equalToSuperview()
        }

        womanButton.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.width.equalTo(56)
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
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

        searchableSwitch.snp.makeConstraints {
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
            $0.centerX.equalToSuperview()
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
