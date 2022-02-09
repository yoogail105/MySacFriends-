//
//  MyPageProfileTableViewCell.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/02/10.
//

import UIKit
import Then
import SnapKit

class MyPageProfileTableViewCell: UITableViewCell {
    static let identifier = "MyPageProfileTableViewCell"
    
    var userImage = UIImageView().then {
        $0.image = UIImage(named: AssetIcon.profileIcon.rawValue)
    }
    
    var nicknameLabel = UILabel().then({
        $0.text = UserDefaults.standard.nickname
        $0.font = UIFont().Title1_M16
        $0.textColor = UIColor.black
    })
    
    var button = UIButton().then {
        $0.setImage(UIImage(named: AssetIcon.moreArrow.rawValue), for: .normal)
    }

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubViews()
        constraints()
       
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError()
    }
    func addSubViews() {
        [userImage, nicknameLabel, button].forEach {
            addSubview($0)
        }
    }
    
    func constraints() {
        
        userImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(50)
            $0.leading.equalToSuperview().offset(15)
        }
        
        nicknameLabel.snp.makeConstraints {
            $0.centerY.equalTo(userImage.snp.centerY)
            $0.leading.equalTo(userImage.snp.trailing).offset(13)
            $0.trailing.equalTo(button.snp.leading).offset(-30)
        }
        
        button.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.2)
            $0.width.equalTo(self.snp.height).multipliedBy(0.5)
            $0.trailing.equalToSuperview().offset(-16)
        }
    }
}
