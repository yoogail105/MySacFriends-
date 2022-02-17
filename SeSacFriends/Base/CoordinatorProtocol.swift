//
//  CoordinatorProtocol.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/27.
//

import UIKit

protocol Coordinator: AnyObject {
    // var parentCoordinator: Coordinator? { get set } // 패런츠가없음. 자기자신.
    var childCoordinators: [Coordinator] { get set }
//    var navigationController: UINavigationController { get set }
    
    func start()
    
}

class MainCoordinator: Coordinator {
    // var parentCoordinator: Coordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
    
    func start() {
        let viewController = OnboardingViewController()
        viewController.coordinator = self
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func pushToAuth() {
        let viewController = AuthViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func pushToAuthSignUp() {
        let viewController = SignUpNicknameViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func pushToMainTabBar() {
        
        //                let vc = MainTabBarController()
        //                navigationController.pushViewController(vc, animated: true)
//        navigationController.viewControllers.removeAll()
//        navigationController.isToolbarHidden = true
        let child = TabBarCoordinator(navigationController: navigationController!)
        child.parentCoordinator = self
        childCoordinators.append(child)
        
        child.start()
    }
    
    //화면이 사라질 때 호출
    //viewDidDisappear(), Navigation Controller Delegate의 didShow()
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}

//protocol Coordinator1: AnyObject {
//    var childCoordinator: [Coordinator1] { get set }
//
//    func start()
//}
//
//// MARK: HomeCoordinator
//class HomeCoordinator: Coordinator1 {
//
//    weak var parentCoordinator: Coordinator1?
//    var childCoordinator: [Coordinator1] = []
//    var navigationController: UINavigationController
//
//    init() {
//        self.navigationController = .init()
//    }
//
//    func start() {
//
//    }
//
//    func startPush() -> UINavigationController {
//        let homeViewController = HomeViewController()
//        homeViewController.title = TabBarTitle.home.rawValue
//        navigationController.setViewControllers([homeViewController], animated: false)
//
//        return navigationController
//    }
//
//}
//
//
//
// //MARK: ShopCoordinator
//class ShopCoordinator: Coordinator1 {
//
//    weak var parentCoordinator: Coordinator1?
//    var childCoordinator: [Coordinator1] = []
//    var navigationController: UINavigationController
//
//    init() {
//        self.navigationController = .init()
//    }
//
//    func start() {
//
//    }
//
//    func startPush() -> UINavigationController {
//        let shopViewController = ShopViewController()
//        navigationController.setViewControllers([shopViewController], animated: false)
//        return navigationController
//    }
//}
//
//
//
//// MARK:friendsCoordinator
//class FriendsCoordinator: Coordinator1 {
//
//    weak var parentCoordinator: Coordinator1?
//    var childCoordinator: [Coordinator1] = []
//    var navigationController: UINavigationController
//
//    init() {
//        self.navigationController = .init()
//    }
//
//    func start() {
//
//    }
//
//    func startPush() -> UINavigationController {
//        let friendsCoordinator = FriendsViewController()
//        navigationController.setViewControllers([friendsCoordinator], animated: false)
//        return navigationController
//    }
//}
//
//
//// MARK: MyPageCoordinator
//class MyPageCoordinator: Coordinator1 {
//
//    weak var parentCoordinator: Coordinator1?
//    var childCoordinator: [Coordinator1] = []
//    var navigationController: UINavigationController
//
//    init() {
//        self.navigationController = .init()
//    }
//
//    func start() {
//
//    }
//
//    func startPush() -> UINavigationController {
//        let myPageViewController = MyPageViewController()
//        myPageViewController.title = TabBarTitle.myPage.rawValue
//        navigationController.setViewControllers([myPageViewController], animated: false)
//        return navigationController
//    }
//}
//

class TabBarCoordinator: Coordinator {
    
    weak var parentCoordinator: MainCoordinator?
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        
        let tabBarController = UITabBarController()
//        tabBarController.coordinator = self
        
        
        let homeBarItem = UITabBarItem(title: TabBarTitle.home.rawValue, image: UIImage(named: TabBarIcon.homeInact.rawValue)?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: TabBarIcon.homeAct.rawValue)?.withRenderingMode(.alwaysOriginal))
        let homeCoordinator = HomeCoordinator(navigationController: navigationController)
        homeCoordinator.parentCoordinator = self
        childCoordinators.append(homeCoordinator)
        let home = homeCoordinator.startPush()
        home.tabBarItem = homeBarItem
        
        
        let  friendsBarItem = UITabBarItem(title: TabBarTitle.friends.rawValue, image: UIImage(named: TabBarIcon.friendsInact.rawValue)?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: TabBarIcon.friendsAct.rawValue)?.withRenderingMode(.alwaysOriginal))
        let friendsCoordinator = FriendsCoordinator(navigationController: navigationController)
        friendsCoordinator.parentCoordinator = self
        childCoordinators.append(friendsCoordinator)
        let friends = friendsCoordinator.startPush()
        friends.tabBarItem = friendsBarItem
        
        
        
        let shopBarItem = UITabBarItem(title: TabBarTitle.shop.rawValue, image: UIImage(named: TabBarIcon.shopInact.rawValue)?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: TabBarIcon.shopAct.rawValue)?.withRenderingMode(.alwaysOriginal))
        let shopCoordinator = ShopCoordinator(navigationController: navigationController)
        shopCoordinator.parentCoordinator = self
        childCoordinators.append(shopCoordinator)
        let shop = shopCoordinator.startPush()
        shop.tabBarItem = shopBarItem
        
        
       
        let myPageBarItem = UITabBarItem(title: TabBarTitle.myPage.rawValue, image: UIImage(named: TabBarIcon.myInact.rawValue)?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: TabBarIcon.myAct.rawValue)?.withRenderingMode(.alwaysOriginal))
        let myPageCoordinator = MyPageCoordinator(navigationController: navigationController)
        myPageCoordinator.parentCoordinator = self
        childCoordinators.append(myPageCoordinator)
        let myPage = myPageCoordinator.startPush()
        myPage.tabBarItem = myPageBarItem
        
        
        tabBarController.navigationController?.navigationBar.isHidden = true
        //tabBarController.navigationController?.setNavigationBarHidden(true, animated: true)
        tabBarController.viewControllers = [home, shop, friends, myPage]
        navigationController.pushViewController(tabBarController, animated: true)
        
    }
    
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
        
    }
}

// MARK: HomeCoordinator
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
        //navigationController.setViewControllers([homeViewController], animated: false)
        return navigationController
    }
}

// MARK:friendsCoordinator
class FriendsCoordinator: Coordinator {
    weak var parentCoordinator: TabBarCoordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        
    }
    
    func startPush() -> UINavigationController {
        let rootViewController = FriendsViewController()
        rootViewController.title = TabBarTitle.friends.rawValue
        navigationController = UINavigationController(rootViewController: rootViewController)
        //navigationController.setViewControllers([homeViewController], animated: false)
        return navigationController
    }
}



//MARK: ShopCoordinatorCoordinator
class ShopCoordinator: Coordinator {
    
    weak var parentCoordinator: TabBarCoordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        
    }
    
    func startPush() -> UINavigationController {
        let shopViewController = ShopViewController()
        navigationController = UINavigationController(rootViewController: shopViewController)
//        navigationController.setViewControllers([shopViewController], animated: false)
        return navigationController
    }
}



// MARK: MyPageCoordinator
class MyPageCoordinator: Coordinator {
    
    weak var parentCoordinator: TabBarCoordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        
    }
    
    func startPush() -> UINavigationController {
        let rootViewController = MyPageViewController()
        rootViewController.title = TabBarTitle.myPage.rawValue
        navigationController = UINavigationController(rootViewController: rootViewController)
//        navigationController.setViewControllers([myPageViewController], animated: false)
        return navigationController
    }
}

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

