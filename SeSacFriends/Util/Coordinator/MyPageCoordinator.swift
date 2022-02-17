//
//  MyPageCoordinator.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/02/17.
//

import UIKit

class MyPageCoordinator: Coordinator {
    
    weak var parentCoordinator: TabBarCoordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        
    }
    
    func startPush() -> UINavigationController {
        
        let rootViewController = MyPageViewController()
        rootViewController.title = TabBarTitle.myPage.rawValue
        navigationController = UINavigationController(rootViewController: rootViewController)
        //navigationController.setViewControllers([homeViewController], animated: false)
        return navigationController
    }
    
    func pushToWithdrawal() {
        let rootViewController = withdrawalViewController()
        rootViewController.coordinator = self
        rootViewController.modalPresentationStyle = .overCurrentContext
        rootViewController.modalTransitionStyle = .crossDissolve
        navigationController.present(rootViewController, animated: true, completion: nil)

//        navigationController.pushViewController(rootViewController, animated: true)
    }
    
    func pushToOnboarding() {
        let rootViewController = OnboardingViewController()
        navigationController.pushViewController(rootViewController, animated: true)
    }
}
