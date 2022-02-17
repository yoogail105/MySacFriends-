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
    var onErrorHandling: ((APIErrorCode) -> Void)?
    
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
    
    
    
    func postSignUp( _ completion: ((Result<Bool, APIErrorCode>) -> Void)? = nil) {
        UserAPIService.signUp { user, result in
            switch result {
                
            case .ok:
                UserDefaults.standard.startMode = StartMode.main.rawValue
                self.onErrorHandling?(.ok)
                
            case .unAuthorized:
                AuthAPIService.fetchIDToken {_ in 
                    print("토큰 가져오기 완료: \(UserDefaults.standard.idToken!)")
                    self.onErrorHandling?(.unAuthorized)

                }
            case .created:
                print("이미 가입된 유저")
                self.onErrorHandling?(.created)
            default:
              print("알수없는 에러가 발생했다.")
            }
        }
    }

}

