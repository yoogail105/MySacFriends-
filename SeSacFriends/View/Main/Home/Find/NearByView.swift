//
//  NearByNearByView.swift
//
//
//  Created by 성민주민주 on 2022/02/22.
//

import UIKit

class NearByView: BaseUIView {
    
    var isEmpty = true
    
    let tableView = UITableView().then {
        $0.rowHeight = UITableView.automaticDimension
        $0.backgroundColor = .white
        $0.separatorStyle = .singleLine
        $0.register(MyPageProfileTableViewCell.self, forCellReuseIdentifier: MyPageProfileTableViewCell.identifier)
    }
    
    
    var sesacBlackImage = UIImageView().then {
        $0.image = UIImage(named: AssetIcon.sesacBlack.rawValue)
    }
    
    var emptyFriendsTitle = UILabel().then {
        // $0.text = HobbyViewText.emptyFriendsTitle.rawValue
        $0.font = UIFont().Display1_R20
        $0.textColor = .black
    }
    
    var emptyFriendsSubtitle = UILabel().then {
        $0.text = HobbyViewText.emptyPageSubtitle.rawValue
        $0.font = UIFont().Title4_R14
        $0.textColor = UIColor.grayColor(.gray7)
    }
    
    
    
    override func addViews() {
            addSubview(tableView)
    }
    
    override func configuration() {
        backgroundColor = .clear
    }
    
//
    override func constraints() {
        
        [sesacBlackImage, emptyFriendsTitle, emptyFriendsSubtitle].forEach {
            addSubview($0)
        }
        
        emptyFriendsTitle.snp.makeConstraints {
            $0.centerY.centerX.equalToSuperview()
        
        }
        
        emptyFriendsSubtitle.snp.makeConstraints {
            $0.top.equalTo(emptyFriendsTitle.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
            
        }
        
        sesacBlackImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(emptyFriendsTitle.snp.top).offset(-32)
            $0.width.height.equalTo(64)
        }

        tableView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview().offset(-100)
        }
    }
    
}
