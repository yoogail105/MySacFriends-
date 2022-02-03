//
//  GenderViewController.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/23.
//

import UIKit
import RxCocoa
import RxSwift
import AVFoundation

class GenderViewController: BaseViewController {
    
    //weak var coordinator: HomeCoordinator?
    
    let mainView = GenderView()
    let viewModel = SignUpViewModel()
    let disposeBag = DisposeBag()
    var gender = UserDefaults.standard.gender
    var woman = false
    var man = false
    override func loadView() { 
        self.view = mainView

    }
    
//
    override func viewDidLoad() {
        super.viewDidLoad()
        print("gender: viewdidload")
        print("gender: ",userDefaults.gender)
        
    }
    
    override func bind() {
        
        viewModel.genderObserver
            .map { $0 == .woman ? UIColor.brandColor(.whitegreen) : UIColor.white }
            .bind(to: mainView.button00.rx.backgroundColor)
            .disposed(by: disposeBag)
        
        viewModel.genderObserver
            .map { $0 == .man ? UIColor.brandColor(.whitegreen) : UIColor.white }
            .bind(to: mainView.button01.rx.backgroundColor)
            .disposed(by: disposeBag)
        
        
       
        mainView.button00.rx.tap
            .scan(Gender.none, accumulator: { lastSelected, _ in
                switch lastSelected {
                case .woman:
                    if self.mainView.button00.backgroundColor == UIColor.white {
                        return .woman
                    }
                    return .none
                case .none:
                    return .woman
                case .man:
                    return .woman
                }
            })
            .bind(to: viewModel.genderObserver)
            .disposed(by: disposeBag)

        mainView.button01.rx.tap
            .scan(Gender.none, accumulator: { lastSelected, _ in
                switch lastSelected {
                case .woman:
                    return .man
                case .none:
                    return .man
                case .man:
                    if self.mainView.button01.backgroundColor == UIColor.white {
                        return .man
                    }
                    return .none
                }
            })
            .bind(to: viewModel.genderObserver)
            .disposed(by: disposeBag)
        
        mainView.nextButton.rx.tap
            .subscribe(onNext: { _ in
                self.signUpSerer()
            })
            .disposed(by: disposeBag)

    }
    
    override func addAction() {
        mainView.button00.addTarget(self, action: #selector(womanButtonClicked), for: .touchUpInside)
        mainView.button01.addTarget(self, action: #selector(manButtonClicked), for: .touchUpInside)
    }
    
    @objc func womanButtonClicked() {
        var lastSelected = userDefaults.gender
        if lastSelected == Gender.woman.rawValue {
            userDefaults.gender = Gender.none.rawValue
            print("여자버튼클릭해제: \(userDefaults.gender)")
        } else {
            userDefaults.gender = Gender.woman.rawValue
            print("여자버튼클릭: \(userDefaults.gender)")
        }
        
    }
    
    @objc func manButtonClicked() {
        var lastSelected = userDefaults.gender
        if lastSelected == Gender.man.rawValue {
            userDefaults.gender = Gender.none.rawValue
            print("남자버튼클릭해제: \(userDefaults.gender)")
        } else {
            userDefaults.gender = Gender.man.rawValue
            print("남자버튼클릭: \(userDefaults.gender)")
        }
    }
    
    private func signUpSerer() {
        viewModel.postSignUp { error in
            if error != nil {
                print(error)
                if error == .unAuthorized {
                    self.showToast(message: "오류가 생겼습니다.\n다시 버튼을 눌러주세요.")
                }
                return
            }
            
            self.moveToNext()
        }
    }
    
    private func moveToNext() {
//        coordinator?.pushToHomeTab(navigationController!)
        // 유저정보 post
//        
//        //print("gender: \(userDefaults.gender)")
//        //print("fcm: \()")
        let vc = MainViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
