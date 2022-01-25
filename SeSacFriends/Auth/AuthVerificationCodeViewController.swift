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
                        self.showToast(message: APIError.tooManyRequests.rawValue)
                        return
                    default:
                        self.showToast(message: APIError.failed.rawValue)
                        return
                    }
                }
                print("인증번호 보냈어요. 타이머 다시 시작하기")
            }
        }
    }
    
    func verifyButtonClicked() {
        self.viewModel.checkVerificationCode(verificationCode: mainView.numberTextField.text!) { error in
            if error == .verificaitonToken {
                self.showToast(message: APIError.verificaitonToken.rawValue)
                return
            } else {
            
            self.viewModel.fetchIDToken {
                print("id토큰가져오기 완료")
                self.viewModel.getUser {
                    print("user 등록된 유저: 로그인완료")
                    self.selectNextView()
                }
            }

            }
        }
        
    }
    
    
    // 회원가입 or 메인화면
    func selectNextView() {
        print(#function, "to signUpNicknameVC, mode: \(UserDefaults.standard.startMode)")
        let mode = UserDefaults.standard.startMode
        if mode == StartMode.signUp.rawValue {
           moveToNext(nextVC: SignUpNicknameViewController())
        } else {
            moveToNext(nextVC: MainViewController())
        }
    }
    
    
    func moveToNext(nextVC: UIViewController) {
        DispatchQueue.main.async {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
            
            windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: nextVC)
            windowScene.windows.first?.makeKeyAndVisible()
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
