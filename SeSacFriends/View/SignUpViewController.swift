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
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super .viewDidLoad()
        
        

    }
    
    override func bind() {
        
        mainView.numberTextField.rx.text
            .orEmpty
            .bind(to: viewModel.certificationCodeObserver)
            .disposed(by: disposeBag)
        
        viewModel.isValidCertificationCode
            .map { $0 ? UIColor.brandColor(.green) : UIColor.grayColor(.gray6)}
            .bind(to: mainView.verifyButton.rx.backgroundColor)
            .disposed(by: disposeBag)
        
        mainView.reSendButton.rx.tap
            .subscribe(onNext: { _ in
                self.sendVerifyNumberButtonClicked()
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
    
    override func setupConstraints() {
        
//        mainView.mainLabel.text = "인증번호가 문자로 전송되었어요."
//        mainView.numberTextField.placeholder = "인증번호 입력"
//        mainView.verifyButton.setTitle("인증하고 시작하기", for: .normal)
    }
    
//    override func addAction() {
//        mainView.verifyButton.addTarget(self, action: #selector(sendVerifyNumberButtonClicked), for: .touchUpInside)
//    }
    
    func sendVerifyNumberButtonClicked() {
        UserDefaults.standard.phoneNumber = viewModel.phoneNumberObserver.value
        showToastWithAction(message: "전화 번호 인증 시작") {
            self.viewModel.postVerificationCode {
                print("인증번호보냈습니다.")
                
            }
        }
        
                    
    }

    
}
