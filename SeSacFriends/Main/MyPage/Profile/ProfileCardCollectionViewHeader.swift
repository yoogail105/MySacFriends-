//
//  ProfileCardTableViewHeader.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/02/02.
//

import UIKit
import SnapKit

class ProfileCardCollectionViewHeader: UICollectionReusableView {
    
    static let identifier = "ProfileCardCollectionViewHeader"
    
    let sectionNameLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        sectionNameLabel.font = UIFont().Body1_M16
        sectionNameLabel.textColor = .black
        sectionNameLabel.sizeToFit()
        
        addSubview(sectionNameLabel)
        
        sectionNameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.top.bottom.leading.equalToSuperview().offset(10)
        }
    }
}
