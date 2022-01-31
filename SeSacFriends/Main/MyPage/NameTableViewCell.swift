//
//  NameTableViewCell.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/31.
//


import UIKit

class NameTableViewCell: UITableViewCell {
    
    static let identifier = "NameTableViewCell"
    
    let nameLabel = UILabel().then {
        $0.text = UserDefaults.standard.nickname
        $0.font = UIFont().Title1_M16
    }
    
    let openButton = UIButton().then {
        $0.setImage(UIImage(named: AssetIcon.moreArrowDown.rawValue), for: .normal)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        constraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func constraints() {
        [nameLabel, openButton].forEach {
            addSubview($0)
        }
        
        nameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
        }
        
        openButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-18)
            $0.height.equalTo(6)
            $0.width.equalTo(12)
        }
    }
}
