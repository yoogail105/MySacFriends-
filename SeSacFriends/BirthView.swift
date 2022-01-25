//
//  BirthView.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/23.
//

import UIKit


class BirthView: AuthView{
    
    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "ko-KR")
        datePicker.timeZone = .autoupdatingCurrent
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.backgroundColor = .white
        return datePicker
    }() 
    
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    let birthView = BirthTextFieldView()
    
    let yearView: BirthTextFieldView = {
        let view = BirthTextFieldView()
        if UserDefaults.standard.birth != nil {
//            view.textField.text = String(Calendar.current.component(.year, from: UserDefaults.standard.birth!))
        } else {
            view.textField.placeholder = "1990"
        }
        view.label.text = "년"
        return view
    }()
    
    let monthView: BirthTextFieldView = {
        let view = BirthTextFieldView()
        if UserDefaults.standard.birth != nil {
//            view.textField.text = String(Calendar.current.component(.month, from: UserDefaults.standard.birth!))
        } else {
            view.textField.placeholder = "1"
        }
        view.label.text = "월"
        return view
    }()
    
    let dayView: BirthTextFieldView = {
        let view = BirthTextFieldView()
        if UserDefaults.standard.birth != nil {
//            view.textField.text = String(Calendar.current.component(.day, from: UserDefaults.standard.birth!))
        } else {
            view.textField.placeholder = "1"
        }
        view.label.text = "일"
        return view
    }()
    
    override func configuration() {
        mainLabel.text = SignUpText.setBirthday.rawValue
        nextButton.setTitle(SignUpText.nextButton.rawValue, for: .normal)
        
        subLabel.isHidden = true
    }
    
    override func constraints() {
        super.constraints()
       // birthView.textField.inputView = datePicker
        textField.isHidden = true
        
        
        [datePicker, stackView ].forEach {
            addSubview($0)
        }
        
        [yearView, monthView, dayView].forEach {
            stackView.addArrangedSubview($0)
            $0.textField.inputView = datePicker
        }
    
        datePicker.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
        }
      
        stackView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(48)
            $0.bottom.equalTo(nextButton.snp.top).offset(-72)
        }
    }
}
