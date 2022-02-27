//
//  HomeCoordinator.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/02/17.
//

import UIKit

class HomeCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    weak var parentCoordinator: TabBarCoordinator?
    
    var navigationController: UINavigationController
    
    init() {
        self.navigationController = .init()
    }
    
    func start() {
        
    }
    
    func startPush() -> UINavigationController {
        let homeViewController = HomeViewController()
        homeViewController.title = TabBarTitle.home.rawValue
        homeViewController.coordinator = self
        navigationController.setViewControllers([homeViewController], animated: false)
        
        return navigationController
    }
    
}

extension HomeCoordinator{

    
    func pushToSearchHobby(lat: Double, long: Double) {
        print(#function)
        let rootViewController = SearchHobbyViewController()
        rootViewController.coordinator = self
        rootViewController.viewModel.currentLatitude = lat
        rootViewController.viewModel.currentLongitude = long
        print("lat:\(lat), long: \(long)")
        self.navigationController.pushViewController(rootViewController, animated: true)
    }
    
    func pushToFindFriends() {
        let rootViewController = FindViewController()
        rootViewController.coordinator = self
        self.navigationController.pushViewController(rootViewController, animated: true)
    }
    
    func pushToChatting() {
        let rootViewController = ChattingViewController()
        rootViewController.coordinator = self
        self.navigationController.pushViewController(rootViewController, animated: true)
    }
    
    // coordinator 간 전환으로 변경하기
    func finishForGender() {
        let rootViewController = ProfileViewController()
        rootViewController.coordinator = MyPageCoordinator()
        self.navigationController.pushViewController(rootViewController, animated: true)
    }
    
    func finishToOnboarding() {
        parentCoordinator?.parentCoordinator?.start()
    }
    
    func finish() {
        parentCoordinator?.childDidFinish(self)
        self.parentCoordinator?.childDidFinish(self.parentCoordinator)
        self.parentCoordinator?.parentCoordinator?.start()
        
    }
}
