//
//  ProfileCardViewController.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/31.
//

import UIKit

class ProfileCardViewController: BaseViewController {

    
    let mainView = ProfileCardView()
    let headerView = ProfileHeaderView()
    var userTitles = [""]
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = TabBarTitle.detail.rawValue
        
        for userTitle in UserTitleText.allCases {
            userTitles.append(userTitle.rawValue)
        }

      
        
        let tableView = mainView.tableView
        tableView.register(NameTableViewCell.self, forCellReuseIdentifier: NameTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        
        
        let collectionView = mainView.titleCollectionView
    }
    
    
}

extension ProfileCardViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NameTableViewCell.identifier, for: indexPath) as? NameTableViewCell else { return UITableViewCell()}
        cell.selectionStyle = .none
        
        return cell
    }
}
