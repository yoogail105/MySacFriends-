//
//  CoordinatorProtocol.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/27.
//

import UIKit



class TabBarCoordinator: NSObject, Coordinator {
    
    weak var parentCoordinator: MainCoordinator?
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.delegate = self
        navigationController.navigationBar.isHidden = true
        
        let tabBarController = UITabBarController()
        
        let homeBarItem = UITabBarItem(title: TabBarTitle.home.rawValue, image: UIImage(named: TabBarIcon.homeInact.rawValue)?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: TabBarIcon.homeAct.rawValue)?.withRenderingMode(.alwaysOriginal))
        let homeCoordinator = HomeCoordinator()
        homeCoordinator.parentCoordinator = self
        childCoordinators.append(homeCoordinator)
        let home = homeCoordinator.startPush()
        home.tabBarItem = homeBarItem
        
        let  friendsBarItem = UITabBarItem(title: TabBarTitle.friends.rawValue, image: UIImage(named: TabBarIcon.friendsInact.rawValue)?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: TabBarIcon.friendsAct.rawValue)?.withRenderingMode(.alwaysOriginal))
        let friendsCoordinator = FriendsCoordinator()
        friendsCoordinator.parentCoordinator = self
        childCoordinators.append(friendsCoordinator)
        let friends = friendsCoordinator.startPush()
        friends.tabBarItem = friendsBarItem
        
        let shopBarItem = UITabBarItem(title: TabBarTitle.shop.rawValue, image: UIImage(named: TabBarIcon.shopInact.rawValue)?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: TabBarIcon.shopAct.rawValue)?.withRenderingMode(.alwaysOriginal))
        let shopCoordinator = ShopCoordinator()
        shopCoordinator.parentCoordinator = self
        childCoordinators.append(shopCoordinator)
        let shop = shopCoordinator.startPush()
        shop.tabBarItem = shopBarItem
        
        let myPageBarItem = UITabBarItem(title: TabBarTitle.shop.rawValue, image: UIImage(named: TabBarIcon.myInact.rawValue)?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: TabBarIcon.myAct.rawValue)?.withRenderingMode(.alwaysOriginal))
        let myPageCoordinator = MyPageCoordinator()
        myPageCoordinator.parentCoordinator = self
        childCoordinators.append(myPageCoordinator)
        let myPage = myPageCoordinator.startPush()
        myPage.tabBarItem = myPageBarItem
        
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

extension TabBarCoordinator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
    
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }
        
        if let withdrawalViewController = fromViewController as? withdrawalViewController {
            // We're popping a buy view controller; end its coordinator
            print("onbardingViewControllerFinish")
            childDidFinish(withdrawalViewController.coordinator)
        }
        
        if let MyPageViewController = fromViewController as? MyPageViewController {
            print("AuthVerificationCodeViewController in MainCoordi")
            childDidFinish(MyPageViewController.coordinator)
        }
    }
}
