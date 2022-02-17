//
//  CoordinatorProtocol.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/27.
//

import UIKit

class WithdrawalCoordinator: Coordinator {
    
    //var withdrawalCoordinator: WithdrawalCoordinator?
    // MARK:coordinator
    //withdrawalCoordinator = WithdrawalCoordinator(navigationController: self.navigationController!, parentCoordinator: coordinator)
    
    var parentCoordinator: Coordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController, parentCoordinator: Coordinator?) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
    }
    
    func start() {
        let viewController = withdrawalViewController()
        viewController.modalPresentationStyle = .overCurrentContext
        viewController.modalTransitionStyle = .crossDissolve
        navigationController.pushViewController(viewController, animated: true)
    }
    
}

