//
//  HomeCoordinator.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/02/17.
//

import UIKit

class HomeCoordinator: Coordinator {
    
    weak var parentCoordinator: TabBarCoordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        
    }
    
    func startPush() -> UINavigationController {
        let rootViewController = HomeViewController()
        rootViewController.title = TabBarTitle.home.rawValue
        navigationController = UINavigationController(rootViewController: rootViewController)
        return navigationController
    }
    
    
}
