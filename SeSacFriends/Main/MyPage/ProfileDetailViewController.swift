//
//  ProfileDetailViewController.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/28.
//

import UIKit

class ProfileDetailViewController: BaseViewController {
    
    
    let mainView = ProfileDetailView()
    
    override func loadView() {
        self.view = mainView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = TabBarTitle.detail.rawValue
        
    }
    
    
}
