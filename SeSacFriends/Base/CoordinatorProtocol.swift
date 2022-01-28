//
//  CoordinatorProtocol.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/27.
//

import UIKit

protocol Coordinator2 {
  var parentCoordinator: Coordinator2? { get set }
  var childCoordinators: [Coordinator2] { get set }
  var navigationController: UINavigationController { get set }
  
  func start()

}

class MainCoordinator: Coordinator2 {
    var parentCoordinator: Coordinator2?
    var childCoordinators = [Coordinator2]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController, parentCoordinator: Coordinator2?) {
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
        homeViewController.title = TabBarTitle.home.rawValue
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
        myPageViewController.title = TabBarTitle.myPage.rawValue
        navigationController.setViewControllers([myPageViewController], animated: false)
        return navigationController
    }
}
