//
//  CoordinatorProtocol.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/27.
//

import UIKit

public protocol Coordinator: AnyObject {
    
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
        let homeViewController:HomeViewController = HomeViewController()
        //homeViewController.delegate = true
        self.navigationController.viewControllers = [homeViewController]
        
    }
    
}


//    func startPush() -> UINavigationController {
//        let homeViewController = HomeViewController()
//        navigationController.setViewControllers([homeViewController], animated: false)
//        return navigationController
//    }
//}



//MARK: ShopCoordinator

class ShopCoordinator: Coordinator {
    weak var parentCoordinator: Coordinator?
    var childCoordinator: [Coordinator] = []
    unowned let navigationController: UINavigationController
    
    init() {
        self.navigationController = .init()
    }
    func start() {
        let shopViewController = ShopViewController()
        //homeViewController.delegate = true
        self.navigationController.viewControllers = [shopViewController]
        
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
    unowned let navigationController: UINavigationController
    
    init() {
        self.navigationController = .init()
    }
    
    func start() {
        let friendsViewController = FriendsViewController()
        //homeViewController.delegate = true
        self.navigationController.viewControllers = [friendsViewController]
        
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
    unowned let navigationController: UINavigationController
    
    init() {
        self.navigationController = .init()
    }
    
    func start() {
        let myPageViewController = MyPageViewController()
        //homeViewController.delegate = true
        self.navigationController.viewControllers = [myPageViewController]
        
    }
    
}//
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

