//
//  CoordinatorProtocol.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/27.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinator: [Coordinator] { get set }
    
    func start()
}

// MARK: HomeCoordinator
class HomeCoordinator: Coordinator {
    
    weak var parentCoordinator: Coordinator?
    var childCoordinator: [Coordinator] = []
    var navigationController: UINavigationController

    init() {
        self.navigationController = .init()
    }
    
    func start() {
        
    }
    
    func startPush() -> UINavigationController {
        let homeViewController = HomeViewController()
        navigationController.setViewControllers([homeViewController], animated: false)
        return navigationController
    }
}



 //MARK: ShopCoordinator
class ShopCoordinator: Coordinator {
    
    weak var parentCoordinator: Coordinator?
    var childCoordinator: [Coordinator] = []
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



// MARK:friendsCoordinator
class FriendsCoordinator: Coordinator {
    
    weak var parentCoordinator: Coordinator?
    var childCoordinator: [Coordinator] = []
    var navigationController: UINavigationController

    init() {
        self.navigationController = .init()
    }
    
    func start() {
        
    }
    
    func startPush() -> UINavigationController {
        let friendsCoordinator = FriendsViewController()
        navigationController.setViewControllers([friendsCoordinator], animated: false)
        return navigationController
    }
}


// MARK: MyPageCoordinator
class MyPageCoordinator: Coordinator {
    
    weak var parentCoordinator: Coordinator?
    var childCoordinator: [Coordinator] = []
    var navigationController: UINavigationController

    init() {
        self.navigationController = .init()
    }
    
    func start() {
        
    }
    
    func startPush() -> UINavigationController {
        let myPageViewController = MyPageViewController()
        navigationController.setViewControllers([myPageViewController], animated: false)
        return navigationController
    }
}
