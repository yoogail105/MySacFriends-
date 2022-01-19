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
    var phoneNumberObserver = BehaviorRelay<String>(value: "")
    
    var isValidPhoneNumber: Observable<Bool> {
        return phoneNumberObserver.map { $0.validatePhoneNumber() }
    }
    
    func postVerificationCode(completion: @escaping (APIError?) -> Void)  { //결과
        APIService.sendVerificationCode(phoneNumber: phoneNumberObserver.value)
            
        
    }
    
    func checkVerificationCode(completion: @escaping (APIError?) -> Void) {
        APIService.checkVerificationCode(verificationCode: phoneNumberObserver.value)
    }
    
    
}

