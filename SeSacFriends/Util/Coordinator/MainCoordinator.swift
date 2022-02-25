//  CoordinatorProtocol.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/27.
//

import UIKit

class MainCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
    func start() {
        
        navigationController.delegate = self
        navigationController.viewControllers.removeAll()
        navigationController.isToolbarHidden = true

        let child = AuthCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start()
    }
    
    func pushToVerification() {
        navigationController.viewControllers.removeAll()
        navigationController.isToolbarHidden = true

        let child = AuthCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.pushToVerification()
    }
    
    func pushToSignUp() {
        navigationController.viewControllers.removeAll()
        navigationController.isToolbarHidden = true
        let child = AuthCoordinator(navigationController: navigationController)
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
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        // Read the view controller we’re moving from.
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }

        // Check whether our view controller array already contains that view controller. If it does it means we’re pushing a different view controller on top rather than popping it, so exit.
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }

        // We’re still here – it means we’re popping the view controller, so we can check whether it’s a buy view controller
        if let onboardingViewController = fromViewController as? OnboardingViewController {
            // We're popping a buy view controller; end its coordinator
            childDidFinish(onboardingViewController.coordinator)
        }
    }
}
