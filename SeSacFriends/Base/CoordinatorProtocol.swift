//
//  CoordinatorProtocol.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/27.
//

import UIKit

protocol Coordinator: class {
  var parentCoordinator: Coordinator? { get set }
  var childCoordinators: [Coordinator] { get set }
  var navigationController: UINavigationController { get set }
  
  func start()

}

class MainCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController, parentCoordinator: Coordinator?) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
    }

    func start() {
        let viewController = OnboardingViewController()
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func pushToAuth() {
        let viewController = AuthViewController()
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func pushToAuthSignUp() {
        let viewController = SignUpNicknameViewController()
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func pushToAuthMain() {
        let viewController = MainTabBarController()
        navigationController.pushViewController(viewController, animated: true)
    }
}


protocol Coordinator1: AnyObject {
    var childCoordinator: [Coordinator1] { get set }
    
    func start()
}

// MARK: HomeCoordinator
class HomeCoordinator: Coordinator1 {
    
    weak var parentCoordinator: Coordinator1?
    var childCoordinator: [Coordinator1] = []
    var navigationController: UINavigationController

    init() {
        self.navigationController = .init()
    }
    
    func start() {
        
    }
    
    func startPush() -> UINavigationController {
        let homeViewController = HomeViewController()
        homeViewController.title = TabBarTitle.home.rawValue
        navigationController.setViewControllers([homeViewController], animated: false)
        
        return navigationController
    }
}



 //MARK: ShopCoordinator
class ShopCoordinator: Coordinator1 {
    
    weak var parentCoordinator: Coordinator1?
    var childCoordinator: [Coordinator1] = []
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
class FriendsCoordinator: Coordinator1 {
    
    weak var parentCoordinator: Coordinator1?
    var childCoordinator: [Coordinator1] = []
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
class MyPageCoordinator: Coordinator1 {
    
    weak var parentCoordinator: Coordinator1?
    var childCoordinator: [Coordinator1] = []
    var navigationController: UINavigationController

    init() {
        self.navigationController = .init()
    }
    
    func start() {
        
    }
    
    func startPush() -> UINavigationController {
        let myPageViewController = MyPageViewController()
        myPageViewController.title = TabBarTitle.myPage.rawValue
        navigationController.setViewControllers([myPageViewController], animated: false)
        return navigationController
    }
}
