//
//  SignUpViewController.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/18.
//

import UIKit
import RxCocoa
import RxSwift



class AuthVerificationCodeViewController: BaseViewController {
 
    let mainView = AuthVerificationCodeView()
    let viewModel = AuthViewModel()
    let disposeBag = DisposeBag()

    override func loadView() {
        self.view = mainView
    }
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super .viewDidLoad()
        
    }
    
    override func bind() {
        
        mainView.numberTextField.rx.text
            .orEmpty
            .bind(to: viewModel.certificationCodeObserver)
            .disposed(by: disposeBag)
        
        viewModel.phoneNumberObserver
            .map { $0 != "" ? UIColor.black : UIColor.grayColor(.gray3)}
            .bind(to: mainView.line.rx.backgroundColor)
            .disposed(by: disposeBag)
//        
        viewModel.isValidCertificationCode
            .map { $0 ? UIColor.brandColor(.green) : UIColor.grayColor(.gray6)}
            .bind(to: mainView.verifyButton.rx.backgroundColor)
            .disposed(by: disposeBag)
        
        mainView.numberTextField.rx.text
            .orEmpty
            .subscribe(onNext: {
                self.limitVerificationCodeTextField($0)
            })
            .disposed(by: disposeBag)
        
        mainView.reSendButton.rx.tap
            .subscribe(onNext: { _ in
                self.sendVerifyNumberButtonClicked()
            })
            .disposed(by: disposeBag)
        
        mainView.verifyButton.rx.tap
            .withLatestFrom(viewModel.isValidCertificationCode)
            .filter{ $0 } //형식이 맞으면
            .subscribe(onNext: { _ in
                self.verifyButtonClicked()
            })
            .disposed(by: disposeBag)
        
        mainView.verifyButton.rx.tap
            .withLatestFrom(viewModel.isValidCertificationCode)
            .filter{ !$0 }
            .subscribe(onNext: { _ in
                self.showToast(message: "잘못된 전화번호 형식입니다")
            })
            .disposed(by: disposeBag)
        
        // timer
        viewModel.onTimer.asObservable()
          .debug("isRunningFirst") // 로그창에 running true, false 출력
          .flatMapLatest { isRunning in
          isRunning ? Observable<Int>
          .interval(.seconds(1), scheduler: MainScheduler.instance) : .empty()
          }
          .subscribe(onNext: { _ in
           print("timer")
          })
          .disposed(by: disposeBag)
    }
    

    func sendVerifyNumberButtonClicked() {
        showToastWithAction(message: "전화 번호 인증 시작") {
            self.viewModel.postVerificationCode {
                print("인증번호 보냈어요. 타이머 다시 시작하기")
            }
        }
    }
    
    func verifyButtonClicked() {
            self.viewModel.checkVerificationCode {_ in
                print("verificationID: \(UserDefaults.standard.authVerificationID)")
                UserDefaults.standard.startMode = StartMode.signUp.rawValue
            }
        
    }
    
    private func limitVerificationCodeTextField(_ phoneNumber: String) {
        if phoneNumber.count > 6 {
            let index = phoneNumber.index(phoneNumber.startIndex, offsetBy: 6)
            mainView.numberTextField.text = String(phoneNumber[..<index])
        }
    }

    
}
