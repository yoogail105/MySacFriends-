//
//  EmailViewController.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/23.
//

import UIKit
import RxSwift
import RxCocoa

class EmailViewController: BaseViewController {
    
    let mainView = setEmailView()
    let viewModel = SignUpViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func bind() {
        
        mainView.textField.rx.text
            .orEmpty
            .bind(to: viewModel.emailObserver)
            .disposed(by: disposeBag)
        
        viewModel.emailObserver
            .map { $0 != "" ? UIColor.black :  UIColor.grayColor(.gray3)}
            .bind(to: mainView.line.rx.backgroundColor)
            .disposed(by: disposeBag)
        
        viewModel.isValidEmail
            .map { $0 ? UIColor.brandColor(.green) : UIColor.grayColor(.gray3)}
            .bind(to: mainView.nextButton.rx.backgroundColor)
            .disposed(by: disposeBag)
        
        mainView.nextButton.rx.tap
            .withLatestFrom(viewModel.isValidEmail)
            .filter{ $0 }
            .subscribe(onNext: { _ in
                self.moveToNext()
            })
            .disposed(by: disposeBag)
        
        mainView.nextButton.rx.tap
            .withLatestFrom(viewModel.isValidEmail)
            .filter{ !$0 }
            .subscribe(onNext: { _ in
                self.showToast(message: SignUpToast.invalidEmail.rawValue )
            })
            .disposed(by: disposeBag)
        
        
        
    }
    
    private func moveToNext() {
        UserDefaults.standard.email = mainView.textField.text!
        let vc = GenderViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
