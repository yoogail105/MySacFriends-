//
//  SearchViewController.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/02/10.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources


class SearchHobbyViewController: UIViewController {
    
    let mainView = SearchHobbyView()
    
    override func loadView() {
        self.view = mainView
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func bindTableView() {
        let tableView = mainView.tableView
        
        let cities = ["London", "Vienna", "Lisbon"]
    }
}

//TitleTableViewCell
