//
//  OnboardingViewController.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/22.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class OnboardingViewController: BaseViewController  {
    
    let mainView = OnboardingView()
    let cardViewController = PageViewController()
    let disposBag = DisposeBag()
    weak var coordinator: AuthCoordinator?
    
    
    override func loadView() {
        self.view = mainView
  
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserDefaults.standard.startMode = StartMode.onBoarding.rawValue
        
        addChild(cardViewController)
        cardViewController.view.translatesAutoresizingMaskIntoConstraints = false
        mainView.pageView.addSubview(cardViewController.view)
        cardViewController.view.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()

        }
        cardViewController.didMove(toParent: self)
    }
    override func setupNavigationBar() {
        
    }
    
    override func bind() {
        mainView.startButton.rx.tap
            .bind {
                self.toAuthView()
            }
            .disposed(by: disposBag)

    }
    
    func toAuthView() {
        print("toAuthView")
        UserDefaults.standard.startMode = StartMode.auth.rawValue
        coordinator?.pushToVerification()
    }
}
