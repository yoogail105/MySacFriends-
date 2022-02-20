//
//  AuthCoordinator.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/02/17.
//

import UIKit

class AuthCoordinator: Coordinator {
    
    weak var parentCoordinator: MainCoordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = AuthViewController()
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func pushToAuth() {
        let rootViewController = AuthViewController()
        rootViewController.coordinator = self
        navigationController.pushViewController(rootViewController, animated: true)
    }
    
    func pushToSignUp() {
        let rootViewController = SignUpNicknameViewController()
        rootViewController.coordinator = self
        navigationController.pushViewController(rootViewController, animated: true)
    }

    func finish() {

        parentCoordinator?.childDidFinish(self)
        self.parentCoordinator?.pushToMainTabBar()

    }
   
}
extension AuthCoordinator {
    
    func pushToName() {
        let rootViewController = SignUpNicknameViewController()
        navigationController.pushViewController(rootViewController, animated: true)
    }
    
    
    func pushToBirth() {
        let rootViewController = BirthViewController()
        navigationController.pushViewController(rootViewController, animated: true)
    }
    
    func pushToEmail() {
        let rootViewController = EmailViewController()
        navigationController.pushViewController(rootViewController, animated: true)
    }
    
    func pushToGender() {
        let rootViewController = GenderViewController()
        navigationController.pushViewController(rootViewController, animated: true)
    }
}
