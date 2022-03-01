//
//  ReceivedView.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/03/02.
//

import UIKit


class ReceivedView: BaseUIView {
    
    
    let tableView = UITableView().then {
        $0.rowHeight = UITableView.automaticDimension
        $0.backgroundColor = .white
        $0.separatorStyle = .singleLine
        $0.register(MyPageProfileTableViewCell.self, forCellReuseIdentifier: MyPageProfileTableViewCell.identifier)
    }
    
    let sesacBlackImage = UIImageView().then {
        $0.image = UIImage(named: AssetIcon.sesacBlack.rawValue)
    }
    
    let emptyTitle = UILabel().then {
        $0.text = HobbyViewText.emptyRequestTitle.rawValue
        $0.font = UIFont().Display1_R20
        $0.textColor = .black
    }
    
    let emptySubtitle = UILabel().then {
        $0.text = HobbyViewText.emptyPageSubtitle.rawValue
        $0.font = UIFont().Title4_R14
        $0.textColor = UIColor.grayColor(.gray7)
    }
    
    
    
    override func addViews() {
        addSubview(tableView)
        [sesacBlackImage, emptyTitle, emptySubtitle].forEach {
            addSubview($0)
        }
    }

    override func constraints() {
        
        emptyTitle.snp.makeConstraints {
            $0.centerY.centerX.equalToSuperview()
        
        }
        
        emptySubtitle.snp.makeConstraints {
            $0.top.equalTo(emptyTitle.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
            
        }
        
        sesacBlackImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(emptyTitle.snp.top).offset(-32)
            $0.width.height.equalTo(64)
        }
        
        
        tableView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview().offset(-100)
        }
    }
    
}
