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
            .bind(to: viewModel.textFieldObserver)
            .disposed(by: disposeBag)
        
        viewModel.textFieldObserver
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
                self.showToast(message: requestVerificationCodeToast.invalidCodeForamt.rawValue)
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
        showToastWithAction(message: requestVerificationCodeToast.isValid.rawValue) {
            self.viewModel.postVerificationCode { error in
                if error != nil {
                    switch error {
                    case .tooManyRequests:
                        self.showToast(message: APIErrorMessage.tooManyRequests.rawValue)
                        return
                    default:
                        self.showToast(message: APIErrorMessage.failed.rawValue)
                        return
                    }
                }
                print("인증번호 보냈어요. 타이머 다시 시작하기")
            }
        }
    }
    // self.coordinator?.pushToAuthSignUp() : ok이면 화면이동하기
    func verifyButtonClicked() {
        print(#function)
        // 1. firebase인증번호확인
        self.viewModel.onErrorHandling = { result in
            switch result {
            case .ok:
                self.getFirebaseIDToken()
            case .verificationCodeError:
                self.showToast(message: APIErrorMessage.verificationTokenNotMatched.rawValue)
            default:
                print("알수없는 에러")
            }
        }
        self.viewModel.checkVerificationCode(verificationCode: mainView.numberTextField.text!)
    }
                            
    func getFirebaseIDToken() {
        print(#function)
        viewModel.onErrorHandling = { result in
            switch result {
            case .ok:
                //서버에서 유저 확인하기
                self.checkAlreadyExist()
            case .unAuthorized:
                //무한반복..?
                self.viewModel.fetchIDToken()
            default:
                print("알수없는 에러")
            }
        }
        self.viewModel.fetchIDToken()
    }
    
    func checkAlreadyExist() {
        print(#function)
        viewModel.onErrorHandling = {result in
            switch result {
            case .ok:
                self.coordinator?.pushToMainTabBar()
            case .unAuthorized:
                self.checkAlreadyExist()
            case .notAcceptable:
                self.coordinator?.pushToAuthSignUp()
            case .networkError:
                self.showToast(message: APIErrorMessage.networkError.rawValue)
            default:
                self.showToast(message: APIErrorMessage.unKnownError.rawValue)
            }
        }
        self.viewModel.getUser()
    }
    
    // 회원가입 or 메인화면
    func selectNextView() {
        print(#function, "to signUpNicknameVC, mode: \(UserDefaults.standard.startMode)")
        let mode = UserDefaults.standard.startMode
        
        if mode == StartMode.signUp.rawValue {
            self.coordinator?.pushToAuthSignUp()
        } else {
            self.coordinator?.pushToMainTabBar()
        }
    }
    
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
    }
    
    
    private func limitVerificationCodeTextField(_ phoneNumber: String) {
        if phoneNumber.count > 6 {
            let index = phoneNumber.index(phoneNumber.startIndex, offsetBy: 6)
            mainView.numberTextField.text = String(phoneNumber[..<index])
        }
    }
    
    
}
