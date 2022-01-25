//
//  MainViewController.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/18.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: BaseViewController {
    let viewModel = AuthViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        
        viewModel.getUser {
            print("complete")
        }
        
    }
    
}
