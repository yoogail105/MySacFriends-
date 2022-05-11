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
    
    func pushToMatchingMap(lat: Double, long: Double, myHobbyList: [String]) {
        print(#function)
        let rootViewController = HomeViewController()
        rootViewController.coordinator = self
        rootViewController.viewModel.currentLatitude = lat
        rootViewController.viewModel.currentLongitude = long
        rootViewController.viewModel.myHobbyList = myHobbyList
        self.navigationController.pushViewController(rootViewController, animated: true)
    }

    func pushToSearchHobby(lat: Double, long: Double, myHobbyList: [String]?) {
        print(#function)
        let rootViewController = SearchHobbyViewController()
        rootViewController.coordinator = self
        rootViewController.viewModel.currentLatitude = lat
        rootViewController.viewModel.currentLongitude = long
        if let hobbbyList = myHobbyList {
            rootViewController.viewModel.myHobbyList = hobbbyList
        }
        self.navigationController.pushViewController(rootViewController, animated: true)
    }
    
    func pushToNear() -> UIViewController {
        let rootViewController = NearByViewController()
        rootViewController.coordinator = self
        return rootViewController
    }
    
    func pushToReceived() -> UIViewController {
        let rootViewController = ReceivedViewController()
        rootViewController.coordinator = self
        return rootViewController
        
    }
    
    func pushToFindFriends(lat: Double, long: Double, myHobbyList: [String]) {
        let rootViewController = FindViewController()
        rootViewController.coordinator = self
        rootViewController.viewModel.currentLatitude = lat
        rootViewController.viewModel.currentLongitude = long
        rootViewController.viewModel.myHobbyList = myHobbyList
        self.navigationController.pushViewController(rootViewController, animated: true)
    }


    func pushToRequestAcceptAlert(mode: Bool, uid: String) {
        let rootViewController = RequestAcceptViewController()
        rootViewController.coordinator = self
        rootViewController.isRequest = mode
        rootViewController.uid = uid
        rootViewController.modalPresentationStyle = .overCurrentContext
        rootViewController.modalTransitionStyle = .crossDissolve
        self.navigationController.present(rootViewController, animated: true, completion: nil)
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
        //self.parentCoordinator?.parentCoordinator?.start()
        
    }
}

