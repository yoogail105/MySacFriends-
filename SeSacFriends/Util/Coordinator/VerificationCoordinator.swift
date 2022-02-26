//
//  VerificationCoordinator.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/02/25.
//
import UIKit

class VerificationCoordinator: Coordinator {
    
    weak var parentCoordinator: AuthCoordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let rootViewController = AuthViewController()
        rootViewController.coordinator = self
        navigationController.pushViewController(rootViewController, animated: true)
    }
    
    func pushToVerificationCode() {
        let rootViewController = AuthVerificationCodeViewController()
        navigationController.pushViewController(rootViewController, animated: true)
    }
    
    func didFinishBuying() {
        parentCoordinator?.childDidFinish(self)
    } 
    
    
    func finishForMain() {
        parentCoordinator?.childDidFinish(self)
    }
    
}

