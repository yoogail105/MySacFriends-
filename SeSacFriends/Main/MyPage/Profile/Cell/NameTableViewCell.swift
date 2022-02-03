//
//  NameTableViewCell.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/31.
//


import UIKit
import SnapKit

class NameTableViewCell: UITableViewCell {
    
    static let identifier = "NameTableViewCell"
    
    let label = UILabel().then {
        $0.text = "긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것"
        $0.textAlignment = .left
        $0.font = UIFont().Title1_M16
        $0.numberOfLines = 2
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
        [label, openButton].forEach {
            addSubview($0)
        }
        
        label.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalTo(openButton.snp.leading).offset(-8)
            $0.bottom.equalToSuperview().offset(-8)
        }
        
        openButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-18)
            $0.height.equalTo(6)
            $0.width.equalTo(12)
        }
    }
}
