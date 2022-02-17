//
//  CoordinatorProtocol.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/27.
//

import UIKit



class TabBarCoordinator: Coordinator {
    
    weak var parentCoordinator: MainCoordinator?
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        
        navigationController.navigationBar.isHidden = true
        let tabBarController = UITabBarController()
        
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
        
        let myPageBarItem = UITabBarItem(title: TabBarTitle.shop.rawValue, image: UIImage(named: TabBarIcon.myInact.rawValue)?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: TabBarIcon.myAct.rawValue)?.withRenderingMode(.alwaysOriginal))
        let myPageCoordinator = MyPageCoordinator(navigationController: navigationController)
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
