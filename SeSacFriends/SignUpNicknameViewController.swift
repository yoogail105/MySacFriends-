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
    
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
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
            .map { $0 ? UIColor.brandColor(.green) : UIColor.grayColor(.gray3)}
            .bind(to: mainView.nextButton.rx.backgroundColor)
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
    
    private func moveToNext() {
        UserDefaults.standard.nickname = mainView.textField.text!
        let vc = BirthViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func limitNicknameTextField(_ nickname: String) {
        if nickname.count > 10 {
            let index = nickname.index(nickname.startIndex, offsetBy: 10)
            mainView.textField.text = String(nickname[..<index])
        }
    }
    
}
