//
//  ShopCoordinator.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/02/17.
//

import UIKit

class ShopCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    weak var parentCoordinator: TabBarCoordinator?
    
    var navigationController: UINavigationController
    
    init() {
        self.navigationController = .init()
    }
    
    func start() {
        
    }
    func startPush() -> UINavigationController {
        let shopViewController = ShopViewController()
        navigationController.setViewControllers([shopViewController], animated: false)
        return navigationController
    }
}

