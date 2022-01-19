//
//  SignUpViewController.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/18.
//

import UIKit
import RxCocoa
import RxSwift



class SignUpViewController: BaseViewController {
 
    let mainView = AuthVerificationCodeView()
    let viewModel = AuthViewModel()
    let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }
    override func viewDidLoad() {
        super .viewDidLoad()
        
        
        

    }
    
    override func bind() {
        
        mainView.numberTextField.rx.text
            .orEmpty
            .bind(to: viewModel.phoneNumberObserver)
            .disposed(by: disposeBag)
        
            
    }
    
    override func setupConstraints() {
        
//        mainView.mainLabel.text = "인증번호가 문자로 전송되었어요."
//        mainView.numberTextField.placeholder = "인증번호 입력"
//        mainView.verifyButton.setTitle("인증하고 시작하기", for: .normal)
    }
    
    override func addAction() {
        mainView.verifyButton.addTarget(self, action: #selector(sendVerifyNumberButtonClicked), for: .touchUpInside)
    }
    
    @objc func sendVerifyNumberButtonClicked() {
        viewModel.checkVerificationCode { error in
            let vc = MainViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
       
    }

    
}
