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
    
    var phoneNumberObserver = BehaviorRelay<String>(value: "")
    
    var certificationCodeObserver = BehaviorRelay<String>(value: "")
    
    
    var isValidPhoneNumber: Observable<Bool> {
        return phoneNumberObserver.map { $0.validatePhoneNumber() }
    }
    
    var isValidCertificationCode: Observable<Bool> {
        return certificationCodeObserver.map { $0.isValidCertificationCode()}
     }
    
    var onTimer: BehaviorRelay = BehaviorRelay(value: false)
    
    
    
    
    
    func postVerificationCode(completion: @escaping () -> Void)  {
        let phoneNumber = UserDefaults.standard.phoneNumber.phoneNumberFormat()
        AuthAPIService.sendVerificationCode(phoneNumber: phoneNumber) {
            print("인증번호발송완료")
            completion()
        }
        

    }
    
   
    
    func checkVerificationCode(verificationCode: String, completion: @escaping () -> Void) {
        AuthAPIService.checkVerificationCode(verificationCode: verificationCode) {
            print("여기는 AuthViewModel, check완료: \(verificationCode)")
            completion()
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
            
            guard let user = user else {
                return
            }
            
            UserDefaults.standard.startMode = StartMode.main.rawValue

        }
    }
    
    
    
}

