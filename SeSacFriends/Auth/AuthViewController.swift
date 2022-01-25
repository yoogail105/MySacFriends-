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
        
        
    }
    
    override func setupNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    override func bind() {
        
        mainView.textField.rx.text
            .orEmpty
            .bind(to: viewModel.textFieldObserver)
            .disposed(by: disposeBag)
        
        viewModel.textFieldObserver
            .map { $0 != "" ? UIColor.black : UIColor.grayColor(.gray3)}
            .bind(to: mainView.line.rx.backgroundColor)
            .disposed(by: disposeBag)
        
        
        mainView.textField.rx.text
            .orEmpty
            .subscribe(onNext: {
                self.limitPhoneNumberTextField($0)
            })
            .disposed(by: disposeBag)
        
        viewModel.isValidPhoneNumber
            .map { $0 ? UIColor.brandColor(.green) : UIColor.grayColor(.gray3)}
            .bind(to: mainView.nextButton.rx.backgroundColor)
            .disposed(by: disposeBag)
        
        mainView.nextButton.rx.tap
            .withLatestFrom(viewModel.isValidPhoneNumber)
            .filter{ $0 }
            .subscribe(onNext: { _ in
                self.sendVerifyNumberButtonClicked()
            })
            .disposed(by: disposeBag)
        
        mainView.nextButton.rx.tap
            .withLatestFrom(viewModel.isValidPhoneNumber)
            .filter{ !$0 }
            .subscribe(onNext: { _ in
                self.showToast(message: requestVerificationCodeToast.invalidPhoneFormat.rawValue )
            })
            .disposed(by: disposeBag)
        
        //
    }
    
    func showAlert() {
        print("alert!")
    }
    
    
    func sendVerifyNumberButtonClicked() {
        UserDefaults.standard.phoneNumber = mainView.textField.text?.phoneNumberFormat() ?? ""
        
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
                if error != nil {
                    return
                }
                let vc = AuthVerificationCodeViewController()
                self.navigationController?.pushViewController(vc, animated: true)
                print("화면 옮기기")
            }
        }
        
        
    }
    
    
    @objc func verifyButtonClicked() {
        
    }
    
    private func limitPhoneNumberTextField(_ phoneNumber: String) {
        if phoneNumber.count > 11 {
            let index = phoneNumber.index(phoneNumber.startIndex, offsetBy: 11)
            mainView.textField.text = String(phoneNumber[..<index])
        }
    }
    
}
