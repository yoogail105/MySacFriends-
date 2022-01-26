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


//public protocol ShopCoordinator: AnyObject {
//    func pushToShopTab(_ navigationController: UINavigationController)
//}
//
//extension ShopCoordinator {
//
//  func pushToShopTab(_ navigationController: UINavigationController) {
//    let vc = ShopViewController()
//      vc.navigationItem.title = TabBarTitle.shop.rawValue
//
//    navigationController.pushViewController(vc, animated: true)
//  }
//}

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
//protocol friendsCoordinator: AnyObject {
//    func pushToFriendsTab(_ navigationController: UINavigationController)
//}
//extension friendsCoordinator {
//
//  func pushToFriendsTab(_ navigationController: UINavigationController) {
//    let vc = friendsViewController()
//      vc.navigationItem.title = TabBarTitle.friends.rawValue
//    navigationController.pushViewController(vc, animated: true)
//  }
//}


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
//
//protocol MyPageCoordinator: AnyObject {
//    func pushToMyPageTab(_ navigationController: UINavigationController)
//}
//extension MyPageCoordinator {
//
//  func pushToMyPageTab(_ navigationController: UINavigationController) {
//    let vc = MyPageViewController()
//      vc.navigationItem.title = TabBarTitle.myPage.rawValue
//    navigationController.pushViewController(vc, animated: true)
//  }
//}

