//
//  NearBy.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/02/16.
//

import UIKit

class NearByViewController: UIViewController {
    
    let mainView = NearByView()
    let viewModel = FindViewController().viewModel
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addFriends()
    }
    
    func addFriends() {
        print("viewmodel: \(viewModel.nearFriends)")
    }
}
