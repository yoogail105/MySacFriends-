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
    
    func startPush() -> UINavigationController {
        let rootViewController = HomeViewController()
        rootViewController.title = TabBarTitle.home.rawValue
        navigationController = UINavigationController(rootViewController: rootViewController)
        return navigationController
    }
    
   
}
