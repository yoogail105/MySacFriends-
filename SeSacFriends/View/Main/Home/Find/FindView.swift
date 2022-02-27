//
//  FindView.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/02/15.
//

import UIKit
import Tabman
import Pageboy

class FindView: BaseUIView {
    
    
    let bar = TMBar.ButtonBar().then {
        $0.layout.transitionStyle = .snap
        $0.layout.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        $0.backgroundView.style = .clear
        
        $0.buttons.customize { button in
            button.selectedTintColor =  UIColor.brandColor(.green)
            button.tintColor = UIColor.grayColor(.gray6)
               }
        $0.layout.contentMode = .fit
        $0.indicator.tintColor = UIColor.brandColor(.green)
        $0.indicator.overscrollBehavior = .bounce
    }
    
    let changeButton = BaseButton().then {
        $0.buttonMode(.fill, title: HobbyViewText.changeHobby.rawValue)
    }
    
    let refreshButton = BaseButton().then {

        $0.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
        $0.tintColor = UIColor.brandColor(.green)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.brandColor(.green).cgColor
    }
    

    override func constraints() {
        [changeButton, refreshButton].forEach {
            addSubview($0)
        }
        
        
        changeButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview().offset(-50)
            $0.height.equalTo(48)
            $0.trailing.equalTo(refreshButton.snp.leading).offset(-8)
        }
        
        refreshButton.snp.makeConstraints {
            $0.width.height.equalTo(48)
            $0.trailing.equalToSuperview().offset(-16)
            $0.centerY.equalTo(changeButton.snp.centerY)
        }
    }
    
}


