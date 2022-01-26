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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewControllers()
        
    }
    
    
    func setupViewControllers() {
      
     
        let homeBarItem = UITabBarItem(title: TabBarTitle.home.rawValue, image: UIImage(named: TabBarIcon.homeInact.rawValue), selectedImage: UIImage(named: TabBarIcon.homeAct.rawValue))
        home.parentCoordinator = self
        childCoordinator.append(home)
        let home = home.startPush()
        home.tabBarItem = homeBarItem
        
        let shopBarItem = UITabBarItem(title: TabBarTitle.myPage.rawValue, image: UIImage(named: TabBarIcon.shopInact.rawValue), selectedImage: UIImage(named: TabBarIcon.shopAct.rawValue))
        shop.parentCoordinator = self
        childCoordinator.append(shop)
        let shop = shop.startPush()
        shop.tabBarItem = shopBarItem
        
        let  friendsBarItem = UITabBarItem(title: TabBarTitle.myPage.rawValue, image: UIImage(named: TabBarIcon.friendsInact.rawValue), selectedImage: UIImage(named: TabBarIcon.friendsAct.rawValue))
        friends.parentCoordinator = self
        childCoordinator.append(friends)
        let friends = friends.startPush()
        friends.tabBarItem =  friendsBarItem
        
        
        let myPageBarItem = UITabBarItem(title: TabBarTitle.myPage.rawValue, image: UIImage(named: TabBarIcon.myInact.rawValue), selectedImage: UIImage(named: TabBarIcon.myAct.rawValue))
        myPage.parentCoordinator = self
        childCoordinator.append(myPage)
        let myPage = myPage.startPush()
        myPage.tabBarItem = myPageBarItem
        
        viewControllers = [home, shop, friends, myPage]
    }

}


