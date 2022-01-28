//
//  TabBarController.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/27.
//

import UIKit

class MainTabBarController: UITabBarController, Coordinator {

    
    var childCoordinator: [Coordinator] = []
    func start() {
    }
    
    let home = HomeCoordinator()
    let shop = ShopCoordinator()
    let friends = FriendsCoordinator()
    let myPage = MyPageCoordinator()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("진입")
        setupViewControllers()
    }
    
    
    func setupViewControllers() {
      
        
        let homeBarItem = UITabBarItem(title: TabBarTitle.home.rawValue, image: UIImage(named: TabBarIcon.homeInact.rawValue)?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: TabBarIcon.homeAct.rawValue)?.withRenderingMode(.alwaysOriginal))
    
        home.parentCoordinator = self
        childCoordinator.append(home)
        let home = home.startPush()
        home.tabBarItem = homeBarItem
        
        let shopBarItem = UITabBarItem(title: TabBarTitle.shop.rawValue, image: UIImage(named: TabBarIcon.shopInact.rawValue)?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: TabBarIcon.shopAct.rawValue)?.withRenderingMode(.alwaysOriginal))
        shop.parentCoordinator = self
        childCoordinator.append(shop)
        let shop = shop.startPush()
        shop.tabBarItem = shopBarItem
        
        let  friendsBarItem = UITabBarItem(title: TabBarTitle.friends.rawValue, image: UIImage(named: TabBarIcon.friendsInact.rawValue)?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: TabBarIcon.friendsAct.rawValue)?.withRenderingMode(.alwaysOriginal))
        friends.parentCoordinator = self
        childCoordinator.append(friends)
        let friends = friends.startPush()
        friends.tabBarItem =  friendsBarItem
        
        
        let myPageBarItem = UITabBarItem(title: TabBarTitle.myPage.rawValue, image: UIImage(named: TabBarIcon.myInact.rawValue)?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: TabBarIcon.myAct.rawValue)?.withRenderingMode(.alwaysOriginal))
        myPage.parentCoordinator = self
        childCoordinator.append(myPage)
        let myPage = myPage.startPush()
        myPage.tabBarItem = myPageBarItem
        
        viewControllers = [home, shop, friends, myPage]
    }

}
