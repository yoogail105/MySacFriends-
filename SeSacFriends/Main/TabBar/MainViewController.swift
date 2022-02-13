//
//  MainViewController.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/18.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: BaseViewController {
    
    let mainView = MainView()
    let viewModel = AuthViewModel()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
       
        
        self.title = "Map"
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    private func moveToNext() {
        // 유저정보 post
        
        //print("gender: \(userDefaults.gender)")
        //print("fcm: \()")
        UserDefaults.standard.startMode = StartMode.onBoarding.rawValue
        let vc = OnboardingViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
