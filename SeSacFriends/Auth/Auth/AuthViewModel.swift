//
//  AuthViewModel.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/18.
//

import Foundation
import RxSwift
import RxRelay



class AuthViewModel {
    
    var onErrorHandling: ((APIErrorCode) -> Void)?
    
    var buttonMode = BehaviorRelay<String>(value: "false")
    
    var textFieldObserver = PublishRelay<String>()
    
    var onTimer: BehaviorRelay = BehaviorRelay(value: false)
    
    var isValidPhoneNumber: Observable<Bool> {
        return textFieldObserver.map { $0.validatePhoneNumber() }
    }
    
    var isValidCertificationCode: Observable<Bool> {
        return textFieldObserver.map { $0.isValidCertificationCode()}
    }
    
    func checkNetworking() {
        if !NetworkMonitor.shared.isConnected {
            self.onErrorHandling?(.networkError)
            return
        }
    }
    
    func postVerificationCode(completion: @escaping (APIErrorMessage?) -> Void)  {
        if !NetworkMonitor.shared.isConnected {
            completion(.networkError)
        }
        
        let phoneNumber = UserDefaults.standard.phoneNumber
        
        AuthAPIService.sendVerificationCode(phoneNumber: phoneNumber) { error in
            completion(error)
        }
    }
    
    func checkVerificationCode(verificationCode: String, _ completion: ((Result<Bool, APIErrorCode>) -> Void)? = nil) {
        
        checkNetworking()
        
        AuthAPIService.checkVerificationCode(verificationCode: verificationCode) { error in
            guard let error = error else {
                return
            }
            
            if error == .verificationCodeError {
                self.onErrorHandling?(.verificationCodeError)
                return
            }
            
            UserDefaults.standard.startMode = StartMode.signUp.rawValue
            print("인증번호확인완료")
            self.onErrorHandling?(.ok)
        }
    }
    
    func fetchIDToken(_ completion: ((Result<Bool, APIErrorCode>) -> Void)? = nil) {
        checkNetworking()
        AuthAPIService.fetchIDToken { error in
            guard let error = error else {
                return
            }
            
            //여기 에러핸들링..
            if error == .unAuthorized {
                self.onErrorHandling?(.unAuthorized)
            }
            print("토큰가져오기 완료")
            self.onErrorHandling?(.ok)
        }
    }
    
    func getUser(_ completion: ((Result<Bool, APIErrorCode>) -> Void)? = nil) {
        checkNetworking()
        //later in the code
        UserAPIService.login { user, result  in

            switch result {
            case .ok:
                UserDefaults.standard.startMode = StartMode.main.rawValue
                print(UserDefaults.standard.startMode)
                self.onErrorHandling?(.ok)
                
            case .notAcceptable:
                UserDefaults.standard.startMode = StartMode.signUp.rawValue
                self.onErrorHandling?(.notAcceptable)
                
            default:
                self.onErrorHandling?(.internalServerError)
                
            }
        }
    }
}

