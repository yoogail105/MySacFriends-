//
//  TabBarController.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/27.
//

import UIKit

class MainTabBarController: UITabBarController, Coordinator {
    func start() {
        
    }
    
  
    var childCoordinator: [Coordinator] = []

    let home = HomeCoordinator()
    let shop = ShopCoordinator()
    let friends = FriendsCoordinator()
    let myPage = MyPageCoordinator()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
    }
    
    
    func setupViewControllers() {
    // extension으로 뺴기
        
        let homeBarItem = UITabBarItem(title: TabBarTitle.home.rawValue, image: UIImage(named: TabBarIcon.homeInact.rawValue)?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: TabBarIcon.homeAct.rawValue)?.withRenderingMode(.alwaysOriginal))
    
        home.parentCoordinator = self
        childCoordinator.append(home)
        home.start()
        navigationController?.tabBarItem = homeBarItem
        
        let shopBarItem = UITabBarItem(title: TabBarTitle.shop.rawValue, image: UIImage(named: TabBarIcon.shopInact.rawValue)?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: TabBarIcon.shopAct.rawValue)?.withRenderingMode(.alwaysOriginal))
        shop.parentCoordinator = self
        childCoordinator.append(shop)
        shop.start()
        navigationController?.tabBarItem = shopBarItem
        
        
        let  friendsBarItem = UITabBarItem(title: TabBarTitle.friends.rawValue, image: UIImage(named: TabBarIcon.friendsInact.rawValue)?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: TabBarIcon.friendsAct.rawValue)?.withRenderingMode(.alwaysOriginal))
        friends.parentCoordinator = self
        childCoordinator.append(friends)
        friends.start()
        navigationController?.tabBarItem = friendsBarItem
        
        
        let myPageBarItem = UITabBarItem(title: TabBarTitle.myPage.rawValue, image: UIImage(named: TabBarIcon.myInact.rawValue)?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: TabBarIcon.myAct.rawValue)?.withRenderingMode(.alwaysOriginal))
        myPage.parentCoordinator = self
        childCoordinator.append(myPage)
        myPage.start()
        navigationController?.tabBarItem = myPageBarItem
        
        viewControllers = [home.navigationController, shop.navigationController, friends.navigationController, myPage.navigationController]
    }

}


