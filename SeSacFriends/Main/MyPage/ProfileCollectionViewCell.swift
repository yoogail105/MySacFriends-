//
//  ProfileCollectionViewCell.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/31.
//

import UIKit
import SnapKit

class ProfileCollectionViewCell: UICollectionViewCell {
    static let identifier = "ProfileCollectionViewCell"
    
    let userTitleButton = BaseButton().then {
        $0.buttonMode(.inactive, title: UserTitleText.title1.rawValue)
        $0.titleLabel?.font = UIFont().Title4_R14
    }
    
    override func layoutSubviews() {
        // contentView = superView
        contentView.backgroundColor = .white
        
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        
        constraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func constraints() {
        contentView.addSubview(userTitleButton)
        userTitleButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    
}
