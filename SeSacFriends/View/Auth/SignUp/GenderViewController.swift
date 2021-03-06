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
    

    //withdrawalCoordinator = WithdrawalCoordinator(navigationController: self.navigationController!, parentCoordinator: coordinator)
    
    let mainView = GenderView()
    let viewModel = SignUpViewModel()
    
    weak var coordinator: SignUpCoordinator?
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
      //  coordinator = MainCoordinator(navigationController: self.navigationController!)
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
                self.signUpServer()
            })
            .disposed(by: disposeBag)

    }
    
    override func addAction() {
        mainView.button00.addTarget(self, action: #selector(womanButtonClicked), for: .touchUpInside)
        mainView.button01.addTarget(self, action: #selector(manButtonClicked), for: .touchUpInside)
    }
    
    @objc func womanButtonClicked() {
        let lastSelected = userDefaults.gender
        if lastSelected == Gender.woman.rawValue {
            userDefaults.gender = Gender.none.rawValue
            print("여자버튼클릭해제: \(userDefaults.gender)")
        } else {
            userDefaults.gender = Gender.woman.rawValue
            print("여자버튼클릭: \(userDefaults.gender)")
        }
        
    }
    
    @objc func manButtonClicked() {
        let lastSelected = userDefaults.gender
        if lastSelected == Gender.man.rawValue {
            userDefaults.gender = Gender.none.rawValue
            print("남자버튼클릭해제: \(userDefaults.gender)")
        } else {
            userDefaults.gender = Gender.man.rawValue
            print("남자버튼클릭: \(userDefaults.gender)")
        }
    }
    
    private func signUpServer() {
        viewModel.postSignUp()
        viewModel.onErrorHandling = { result in
            
            switch result {
            case .ok:
                self.coordinator?.finishForMainTabBar()
                
            case .created:
                self.showToastWithAction(message: APIErrorMessage.alreadyExisted.rawValue) {
                    self.coordinator?.finishForMainTabBar()
                    // self.coordinator?.pushToMainTabBar()
                }
            case .invalidRequest:
                self.showToastWithAction(message: APIErrorMessage.invalidNickname.rawValue) {
                    self.coordinator?.pushToName()
                }
            case .unAuthorized:
                self.signUpServer()
            case .networkError:
                self.showToast(message: APIErrorMessage.networkError.rawValue)
                
            default:
                self.showToast(message: "알 수 없는 오류가 생겼습니다.\n다시 버튼을 눌러주세요.")
            }
        }
            
        
        
    }
    
    private func moveToNext() {
//        coordinator?.pushToHomeTab(navigationController!)
        // 유저정보 post
//        
//        //print("gender: \(userDefaults.gender)")
//        //print("fcm: \()")
//        coordinator?.finish()
    
        
    }
    
}
