//
//  FindViewController.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/02/15.
//

import UIKit

final class FindViewController: BaseViewController {
    
    let mainView = FindView()
    
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

