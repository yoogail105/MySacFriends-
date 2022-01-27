//
//  MyPageView.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/26.
//

import UIKit
import SnapKit

class MyPageView: UIView {
    
    
    let tableView: UITableView = {
       let table = UITableView()
       // table.register(MyPageTableViewCell.self, forCellReuseIdentifier: MyPageTableViewCell.identifier)
        table.backgroundColor = .yellow
        return table
    }()
    
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
