//
//  FriendCardTableViewCell.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/03/04.
//

import UIKit
import SnapKit

class FriendCardTableViewCell: UITableViewCell {
    
    static let identifier = "FriendCardTableViewCell"
    
    let profileCardView = ProfileCardView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        constraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(row: Friend) {
//        profileCardView.headerView.backgroundImage = row.background
//        profileCardView.headerView.userImage = row.sesac
        profileCardView.headerView.userImage.image = UIImage(named: SesacIcon.face3.rawValue)

        
    }
    
    func constraints() {
        addSubview(profileCardView)
        
        profileCardView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}

