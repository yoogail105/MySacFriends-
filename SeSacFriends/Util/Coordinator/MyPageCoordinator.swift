//
//  MyPageCoordinator.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/02/17.
//

import UIKit

class MyPageCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    weak var parentCoordinator: TabBarCoordinator?
    
    var navigationController: UINavigationController
    
    init() {
        self.navigationController = .init()
    }
    
    func start() {
        
    }
    
    func startPush() -> UINavigationController {
        let myPageViewController = MyPageViewController()
        myPageViewController.title = TabBarTitle.myPage.rawValue
        myPageViewController.coordinator = self
        navigationController.setViewControllers([myPageViewController], animated: false)
        return navigationController
    }
    
    func pushToProfile() {
        let rootViewController = ProfileViewController()
        self.navigationController.pushViewController(rootViewController, animated: true)
    }
    

    
    func pushToWithdrawal() {
        print("코디네이터")
        let rootViewController = withdrawalViewController()
        //rootViewController.coordinator = self
//        rootViewController.modalPresentationStyle = .overCurrentContext
//        rootViewController.modalTransitionStyle = .crossDissolve
//        navigationController.present(rootViewController, animated: true, completion: nil)

        navigationController.pushViewController(rootViewController, animated: true)
    }
    
    func pushToOnboarding() {
        let rootViewController = OnboardingViewController()
        navigationController.pushViewController(rootViewController, animated: true)
    }
}
