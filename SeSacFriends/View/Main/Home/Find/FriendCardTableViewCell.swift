//
//  FriendCardTableViewCell.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/03/04.
//

import UIKit
import SnapKit
import Then

class FriendCardTableViewCell: UITableViewCell {
    
    static let identifier = "FriendCardTableViewCell"
    let profileCardView = ProfileCardView()

    let requestButton = BaseButton().then {
        $0.setTitle(ProfileDetailText.request.rawValue, for: .normal)
        $0.backgroundColor = UIColor.systemColor(.error)
        $0.setTitleColor(.white, for: .normal)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        constraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(row: Friend) {
        /*
        row.reputation
        row.reviews
        */

        profileCardView.friend = row
        profileCardView.tableView.reloadData()
        
        let userSesac = "\(SesacIcon.face.rawValue)\(row.sesac)"
        let defaultSesac = SesacIcon.face0.rawValue
        let userBackground = "\(BackgroundImage.back.rawValue)\(row.background)"
        print("background: \(userBackground)")
        let defaultBackground = BackgroundImage.back0.rawValue
        
        profileCardView.headerView.userImage.image = UIImage(named: (SesacIcon(rawValue: userSesac)?.rawValue) ?? defaultSesac)
        profileCardView.headerView.backgroundImage.image = UIImage(named: (BackgroundImage(rawValue: userBackground)?.rawValue) ?? defaultBackground)
        
    }
    
    func constraints() {
        addSubview(profileCardView)
        
        profileCardView.headerView.addSubview(requestButton)
        requestButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.trailing.equalToSuperview().offset(-12)
            $0.height.equalTo(40)
            $0.width.equalTo(80)
        }
        profileCardView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    

    
}
