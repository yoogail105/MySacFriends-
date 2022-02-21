//  CoordinatorProtocol.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/27.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
    func start() {
        let viewController = OnboardingViewController()
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func pushToAuth() {
        navigationController.viewControllers.removeAll()
        navigationController.isToolbarHidden = true

        let child = AuthCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.pushToAuth()
    }
    
    func pushToAuthSignUp() {
        navigationController.viewControllers.removeAll()
        navigationController.isToolbarHidden = true
        let child = SignUpCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.pushToSignUp()
    }
    
    func pushToMainTabBar() {
        navigationController.viewControllers.removeAll()
        navigationController.isToolbarHidden = true
        let child = TabBarCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        childCoordinators.append(child)
        
        child.start()
    }
    
    //화면이 사라질 때 호출
    //viewDidDisappear(), Navigation Controller Delegate의 didShow()
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}
//
//extension MainCoordinator {
//        func pushToAuthVerificationCode() {
//            let rootViewController = AuthVerificationCodeViewController()
//            rootViewController.mainCoordinator = self
//            navigationController.pushViewController(rootViewController, animated: true)
//        }
//}
