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
    
    var buttonMode = BehaviorRelay<String>(value: "false")
    
    var textFieldObserver = PublishRelay<String>()
    
    var onTimer: BehaviorRelay = BehaviorRelay(value: false)
    
    var isValidPhoneNumber: Observable<Bool> {
        return textFieldObserver.map { $0.validatePhoneNumber() }
    }
    
    var isValidCertificationCode: Observable<Bool> {
        return textFieldObserver.map { $0.isValidCertificationCode()}
    }
    
    func postVerificationCode(completion: @escaping (APIErrorMessage?) -> Void)  {
        let phoneNumber = UserDefaults.standard.phoneNumber
        
        AuthAPIService.sendVerificationCode(phoneNumber: phoneNumber) { error in
            
//            if error != nil {
//                switch error {
//                case .tooManyRequests:
//                    BaseViewController().showToast(message: APIError.tooManyRequests.rawValue)
//                    return
//                default:
//                    BaseViewController().showToast(message: APIError.failed.rawValue)
//                    return
//                }
//            }
            
            completion(error)
        }
    }
    
    
    func checkVerificationCode(verificationCode: String, completion: @escaping (APIErrorMessage?) -> Void) {
        AuthAPIService.checkVerificationCode(verificationCode: verificationCode) { error in
            if error != nil {
                if error == .verificaitonTokenNotMatched {
                    completion(error)
                }
            }
            UserDefaults.standard.startMode = StartMode.signUp.rawValue
            completion(nil)
        }
    }
    
    func fetchIDToken(completion: @escaping () -> Void) {
        AuthAPIService.fetchIDToken {
            
            print("토큰 가져오기 완료: \(UserDefaults.standard.idToken!)")
            completion()
        }
    }
    
    func getUser(completion: @escaping () -> Void) {
        SignUpAPIService.login { user, error in
            
            guard let error = error else {
                return
            }
            
            guard let user = user else {
                return
            }
            
         print("error: ",error)
            if error == .unAuthorized {
                print("토큰 새로 발급 하기")
                self.fetchIDToken {
                    print("토큰 새로 발급 완료")
                }
                return
            }
            
            
            completion()
            
        }
        UserDefaults.standard.startMode = StartMode.main.rawValue
        print(UserDefaults.standard.startMode)
        completion()
    }
    
    
}

