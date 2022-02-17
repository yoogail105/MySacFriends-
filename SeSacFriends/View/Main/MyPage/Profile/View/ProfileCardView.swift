//
//  ProfileCardView.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/31.
//  새싹 카드 테이블 뷰

import UIKit

class ProfileCardView: BaseUIView {
    
    var sectionHeaderTitles: [String] = []
    var userTitles: [String] = []
    
    let headerView = ProfileHeaderView()
    
    let tableView = UITableView().then {
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
        $0.layer.borderColor = UIColor.grayColor(.gray3).cgColor
        $0.layer.borderWidth = 1

    }
    
    let titleCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
       return cv
    }()
    
    
    let colorView = UIView().then {
        $0.backgroundColor = .lightGray
        $0.layer.cornerRadius = 8
    }
    
    override func constraints() {
        
        [headerView, tableView].forEach {
            addSubview($0)
        }
        
        headerView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.trailing.leading.equalTo(headerView)
            $0.bottom.equalToSuperview()
            
        }
        
    }
 
}
