//
//  MyPageView.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/26.
//

import UIKit
import SnapKit

class MyPageView: UIView {
    
    let viewModel = ProfileViewModel()
    let tableView = UITableView().then {
        $0.rowHeight = UITableView.automaticDimension
        $0.backgroundColor = .white
        $0.separatorStyle = .singleLine
        $0.isScrollEnabled = false
        $0.register(MyPageProfileTableViewCell.self, forCellReuseIdentifier: MyPageProfileTableViewCell.identifier)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configuration()
        constraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configuration()
        constraints()
    }
    
    func configuration() {
      

    }
    
    func constraints() {
        addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
}
