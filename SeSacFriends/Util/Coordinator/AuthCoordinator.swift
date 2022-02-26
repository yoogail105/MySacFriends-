//
//  AuthCoordinator.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/02/17.
//

import UIKit

class AuthCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
    
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
        navigationController.delegate = self
        navigationController.viewControllers.removeAll()
        let child = VerificationCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start()
    }
    
    func pushToSignUp() {
        navigationController.delegate = self
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
        if let AuthVerificationCodeViewController = fromViewController as? AuthVerificationCodeViewController {
            // We're popping a buy view controller; end its coordinator
            print("AuthVerificationCodeViewController")
            childDidFinish(AuthVerificationCodeViewController.coordinator)
            if AuthVerificationCodeViewController.alreadyExist {
                self.pushToSignUp()
            } else {
                parentCoordinator?.childDidFinish(self)
            }
        }
    }
}
