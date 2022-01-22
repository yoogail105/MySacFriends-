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
        let phoneNumber = UserDefaults.standard.phoneNumber
        
        APIService.sendVerificationCode(phoneNumber: phoneNumber) {
            print("인증번호발송완료")

        }
        completion()

    }
    
    
    func checkVerificationCode(completion: @escaping (APIError?) -> Void) {
        APIService.checkVerificationCode(verificationCode: phoneNumberObserver.value)
    }
    
}

