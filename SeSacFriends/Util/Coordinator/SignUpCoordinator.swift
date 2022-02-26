//
//  SignUpCoordinator.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/02/21.
//

import UIKit

class SignUpCoordinator: Coordinator {
    
    weak var parentCoordinator: AuthCoordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
    }
    
    func pushToName() {
        let rootViewController = SignUpNicknameViewController()
        rootViewController.coordinator = self
        navigationController.pushViewController(rootViewController, animated: true)
    }
    
//    func pushToSignUp() {
//        let rootViewController = SignUpNicknameViewController()
//        rootViewController.coordinator = self
//        navigationController.pushViewController(rootViewController, animated: true)
//    }
    
    
    func pushToBirth() {
        let rootViewController = BirthViewController()
        rootViewController.coordinator = self
        navigationController.pushViewController(rootViewController, animated: true)
    }
    
    func pushToEmail() {
        let rootViewController = EmailViewController()
        rootViewController.coordinator = self
        navigationController.pushViewController(rootViewController, animated: true)
    }
    
    func pushToGender() {
        print("gender")
        let rootViewController = GenderViewController()
        rootViewController.coordinator = self
        navigationController.pushViewController(rootViewController, animated: true)
    }

    func finishForMainTabBar() {
        self.parentCoordinator?.parentCoordinator?.pushToMainTabBar()
    }
   
}
