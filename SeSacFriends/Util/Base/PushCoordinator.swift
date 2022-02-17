//
//  PushCoordinator.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/27.
//

import UIKit
/*pushViewController
 1. onboarding
 2. Auth
 3. SignUp
 4. MainTabBar
 */



protocol PushOnboardingCoordinator: AnyObject {
    
    func start(_ navigationController: UINavigationController)
}

extension PushOnboardingCoordinator {
    func start(_ navigationController: UINavigationController) {
        let vc = OnboardingViewController()
        navigationController.pushViewController(vc, animated: true)
    }
}


protocol PushAuthCoordinator: AnyObject {
    func start(_ navigationController: UINavigationController)
}

extension PushAuthCoordinator {
    func start(_ navigationController: UINavigationController) {
        let vc = AuthViewController()
        navigationController.pushViewController(vc, animated: true)
    }
}

protocol PushSignUpCoordinator: Coordinator {
    func start(_ navigationController: UINavigationController)
}

extension PushSignUpCoordinator {
    func start(_ navigationController: UINavigationController) {
        let vc = SignUpNicknameViewController()
        navigationController.pushViewController(vc, animated: true)
    }
}

protocol PushMainTabCoordinator: Coordinator {
    
    func start(_ navigationController: UINavigationController)
}

extension PushMainTabCoordinator {
    
    func start(_ navigationController: UINavigationController) {
        let vc = MainTabBarController()
        navigationController.pushViewController(vc, animated: true)
    }
}
