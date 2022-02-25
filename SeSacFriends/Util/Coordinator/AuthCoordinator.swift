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
        navigationController.viewControllers.removeAll()
        let rootViewController = OnboardingViewController()
        rootViewController.coordinator = self
        navigationController.pushViewController(rootViewController, animated: true)
    }
    
    func pushToVerification() {
        navigationController.viewControllers.removeAll()
        let child = VerificationCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start()
    }
    
    func pushToSignUp() {
        navigationController.viewControllers.removeAll()
        let child = SignUpCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.pushToName()
    }

    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
        
    }
   
}
