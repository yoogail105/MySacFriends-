//
//  ChattingViewController.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/02/27.
//

import UIKit

class ChattingViewController: BaseViewController {
    
    
    weak var coordinator: HomeCoordinator?
    let mainView = ChatView()
    let viewModel = ChatViewModel()
    
    override func loadView() {
        self.view = mainView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}
