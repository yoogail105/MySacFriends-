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
        //view.backgroundColor = .yellow
        
        
        
    }
    
    override func addAction() {
        mainView.button.addTarget(self, action: #selector(cancelButtonClicked), for: .touchUpInside)
    }
    
    @objc func cancelButtonClicked() {
        print("버튼 클릭됨")
        SignUpViewModel().deleteUser { error in
            if error != nil {
                print("mainview 탈퇴오류: \(error)")
                if error == .notAcceptable {
                    self.showToast(message: APIErrorMessage.deletedUser.rawValue)
                    return
                }
            } else {
                self.showToast(message: "회원 삭제가 완료되었습니다.")
                self.moveToNext()
                
            }
            
        }
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
