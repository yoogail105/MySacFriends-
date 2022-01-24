//
//  SignUpViewModel.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/23.
//

import Foundation
import RxSwift
import RxRelay

class SignUpViewModel {
    
    var buttonMode = BehaviorRelay<String>(value: "false")
    var nicknameObserver = BehaviorRelay<String>(value: "")
    var emailObserver = BehaviorRelay<String>(value: "")
    var genderObserver = PublishRelay<Gender>()
    var birthObserver = PublishRelay<Date>()
    
    var isValidEmail: Observable<Bool> {
        return emailObserver.map { $0.validateEmail() }
    }
    
   // var certificationCodeObserver = BehaviorRelay<String>(value: "")
    
//
//    var isValidnickname: Observable<Bool> {
//        return phoneNumberObserver.map { $0.validatePhoneNumber() }
//    }
    
    var isValidNickname: Observable<Bool> {
        return nicknameObserver.map { $0 != "" ? true : false }
     }
    
    //var onTimer: BehaviorRelay = BehaviorRelay(value: false)
    
    
    
    func postSignUp(completion: @escaping (APIError?) -> Void) {
        SignUpAPIService.signUp { userData, error in
            if error != nil {
                completion(error)
            }
            
            guard userData != nil else {
                print("userData는; ", userData)
                return
            }
            
            print("회원가입성공")
            
            completion(error)
        }
    }
    
}

