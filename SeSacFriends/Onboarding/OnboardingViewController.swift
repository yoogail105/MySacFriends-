//
//  OnboardingViewController.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/22.
//

import UIKit
import SnapKit

class OnboardingViewController: BaseViewController {
    
    let mainView = OnboardingView()
    let cardViewController = PageViewController()
//    let cardView = OnboardingCardView()
    
    override func loadView() {
        self.view = mainView
  
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChild(cardViewController)
        cardViewController.view.translatesAutoresizingMaskIntoConstraints = false
        mainView.pageView.addSubview(cardViewController.view)
        cardViewController.view.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()

        }
        cardViewController.didMove(toParent: self)
    }
    
}
