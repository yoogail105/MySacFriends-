//
//  ProfileCardReviewTableViewCell.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/02/03.
//

import UIKit
import SnapKit

class ProfileCardReviewTableViewCell: UITableViewCell {
    
    static let identifier = "ProfileCardReviewTableViewCell"
    
    let label = UILabel().then {
        $0.text = "긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것긴것"
        $0.font = UIFont().Body3_R14
        $0.numberOfLines = 2
    }

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        constraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func constraints() {
        [label].forEach {
            addSubview($0)
        }
        
        label.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview().offset(-8)
        }
        
      
    }
}
