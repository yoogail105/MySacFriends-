//
//  RequestViewController.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/02/16.
//

import UIKit

class ReceivedViewController: UIViewController {
    let mainView = ReceivedView()
    weak var viewModel: QueueViewModel?
    
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
