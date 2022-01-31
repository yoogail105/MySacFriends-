//
//  ProfileCollectionViewCell.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/31.
//

import UIKit

class ProfileCollectionViewCell: UICollectionViewCell {
    static let identifier = "ProfileCollectionViewCell"
    
    let userTitleButton = UIButton().then {
        $0.buttonMode(.inactive, title: UserTitleText.title1.rawValue)
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(userTitleButton)
        
        constraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func constraints() {
        userTitleButton.snp.makeConstraints {
            $0.top.bottom.trailing.leading.equalToSuperview()
        }
    }
}
