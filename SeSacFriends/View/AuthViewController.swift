//
//  AuthViewController.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/18.
//
//
//  ViewController.swift
//  SSAC_FirebaseAuth
//
//  Created by 성민주민주 on 2022/01/17.
//

import UIKit
import FirebaseAuth
import RxSwift
import RxCocoa

class AuthViewController: BaseViewController {
    
    let mainView = AuthView()
    var viewModel = AuthViewModel()
    let disposeBag = DisposeBag()
    var verifyID: String?
    var isValid = false
    
    override func loadView() {
        self.view = mainView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //        mainView.verifyButton.addTarget(self, action: #selector(sendVerifyNumberButtonClicked), for: .touchUpInside)
        //
        //        mainView.verifyButton.addTarget(self, action: #selector(verifyButtonClicked), for: .touchUpInside)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mainView.numberTextField.underLine()
    }
    
    override func bind() {
        
        mainView.numberTextField.rx.text
            .orEmpty
            .bind(to: viewModel.phoneNumberObserver)
            .disposed(by: disposeBag)
        
        mainView.numberTextField.rx.text
            .orEmpty
            .subscribe(onNext: {
                self.limitConfirmNewPasswordTextField($0)
            })
            .disposed(by: disposeBag)
        
        viewModel.isValidPhoneNumber
            .map { $0 ? UIColor.brandColor(.green) : UIColor.grayColor(.gray3)}
            .bind(to: mainView.verifyButton.rx.backgroundColor)
            .disposed(by: disposeBag)
        
        mainView.verifyButton.rx.tap
            .withLatestFrom(viewModel.isValidPhoneNumber)
            .filter{ $0 }
            .subscribe(onNext: { _ in
                self.sendVerifyNumberButtonClicked()
            })
            .disposed(by: disposeBag)
        
        mainView.verifyButton.rx.tap
            .withLatestFrom(viewModel.isValidPhoneNumber)
            .filter{ !$0 }
            .subscribe(onNext: { _ in
                self.showToast(message: "잘못된 전화번호 형식입니다")
            })
            .disposed(by: disposeBag)
        
//
    }
        
        func showAlert() {
            print("alert!")
        }
        
        
        
//        override func addAction() {
//            mainView.verifyButton.addTarget(self, action: #selector(sendVerifyNumberButtonClicked), for: .touchUpInside)
//        }
//
        
        func sendVerifyNumberButtonClicked() {
            UserDefaults.standard.phoneNumber = viewModel.phoneNumberObserver.value
            showToastWithAction(message: "전화 번호 인증 시작") {
                self.viewModel.postVerificationCode {
                    let vc = SignUpViewController()
                    self.navigationController?.pushViewController(vc, animated: true)
                    print("화면 옮기기")
                }
            }
            
                        
        }
        
        @objc func verifyButtonClicked() {
            
        }
        
        private func limitConfirmNewPasswordTextField(_ phoneNumber: String) {
            if phoneNumber.count > 11 {
                let index = phoneNumber.index(phoneNumber.startIndex, offsetBy: 11)
                mainView.numberTextField.text = String(phoneNumber[..<index])
            }
        }
        
    }
    
