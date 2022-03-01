//
//  SignUpNicknameViewController.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/23.
//

import UIKit
import RxSwift
import RxCocoa

class SignUpNicknameViewController: BaseViewController {
    
    let mainView = NicknameView()
    let viewModel = SignUpViewModel()
    let disposeBag = DisposeBag()
    
    weak var coordinator: SignUpCoordinator?
    
    override func loadView() {
        self.view = mainView
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userDefaults.startMode = StartMode.onBoarding.rawValue
        
        if userDefaults.FCMToken == nil {
            viewModel.fetchFCMToken()
        }

    }
    
    override func bind() {
        mainView.textField.rx.text
            .orEmpty
            .bind(to: viewModel.nicknameObserver)
            .disposed(by: disposeBag)
        
        mainView.textField.rx.text
            .orEmpty
            .subscribe(onNext: {
                self.limitNicknameTextField($0)
            })
            .disposed(by: disposeBag)
        
        viewModel.nicknameObserver
            .map { $0 != "" ? UIColor.black : UIColor.grayColor(.gray6)}
            .bind(to: mainView.line.rx.backgroundColor)
            .disposed(by: disposeBag)
        
        viewModel.isValidNickname
            .map { $0 ? CustomButton.fill: CustomButton.disable}
            .subscribe(onNext: { mode in
                self.mainView.nextButton.buttonModeColor(mode)
            })
            .disposed(by: disposeBag)
        
        
        mainView.nextButton.rx.tap
            .withLatestFrom(viewModel.isValidNickname)
            .filter{ $0 }
            .subscribe(onNext: { _ in
                self.moveToNext()
            })
            .disposed(by: disposeBag)
        
        mainView.nextButton.rx.tap
            .withLatestFrom(viewModel.isValidNickname)
            .filter{ !$0 }
            .subscribe(onNext: { _ in
                self.showToast(message: SignUpToast.nicknameCountError.rawValue)
            })
            .disposed(by: disposeBag)
    
        
    }
    
    private func fetchFCMToken() {
        
    }
    
    private func moveToNext() {
        UserDefaults.standard.nickname = mainView.textField.text!
        print("nick: \(userDefaults.nickname)")
       
        coordinator?.pushToBirth()
//        let vc = BirthViewController()
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func limitNicknameTextField(_ nickname: String) {
        if nickname.count > 10 {
            let index = nickname.index(nickname.startIndex, offsetBy: 10)
            mainView.textField.text = String(nickname[..<index])
        }
    }
    
}
