//
//  SignUpViewModel.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/23.
//

import UIKit
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

    var isValidNickname: Observable<Bool> {
        return nicknameObserver.map { $0 != "" ? true : false }
     }
    
    func postSignUp(completion: @escaping (APIErrorCode?) -> Void) {
        UserAPIService.signUp { userData, error in
            if error != nil {
                if error == .unAuthorized {
                    AuthAPIService.fetchIDToken {
                        print("토큰 가져오기 완료: \(UserDefaults.standard.idToken!)")
                    }
                }
                    
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
    
    func deleteUser(completion: @escaping(APIErrorCode?) -> Void) {
        UserAPIService.withdrawalUser { userData, error in
            print(error)
            guard let error = error else {
                return
            }
            
            completion(error)
            
        }
    }
    
    
    
}

