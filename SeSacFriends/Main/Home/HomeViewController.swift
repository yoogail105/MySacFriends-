//
//  HomeViewController.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/27.
//


import UIKit

class HomeViewController: UIViewController {
    
    var coordinator: MainCoordinator?
    let viewModel = AuthViewModel()
    let mainView = HomeView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("유저체크하기")
        checkUser()
        
        mainView.mapView.center = mainView.center
        
        let navigationController = UINavigationController()
        coordinator = MainCoordinator(navigationController: navigationController, parentCoordinator: coordinator)
        
    }
    
    func checkUser() {
        print("")
        viewModel.onErrorHandling = { error in
            if error == .notAcceptable {
                UserDefaults.standard.startMode = StartMode.auth.rawValue
                print("로그인 새로 해야함")
                self.coordinator?.pushToAuthSignUp()
                // 토스트 메세지: 로그인을 해주세요
            } else if error == .unAuthorized {
                print("errorHandling: 로그인 새로 해야함")
                self.coordinator?.pushToAuthSignUp()
            }
        }
        self.viewModel.getUser()
    }
}
 
