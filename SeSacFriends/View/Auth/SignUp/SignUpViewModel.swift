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
    
    
    
    func checkNetworking() {
        if !NetworkMonitor.shared.isConnected {
            self.onErrorHandling?(.networkError)
            return
        }
    }
    
    func postSignUp( _ completion: ((Result<Bool, APIErrorCode>) -> Void)? = nil) {
        checkNetworking()
        let request = SignUpRequest(phoneNumber: UserDefaults.standard.phoneNumber,
                                    FCMtoken: UserDefaults.standard.FCMToken!,
                                    nick: UserDefaults.standard.nickname,
                                    birth: UserDefaults.standard.birth!,
                                    email: UserDefaults.standard.email,
                                    gender: UserDefaults.standard.gender)
        
        UserAPIService.signUp(param: request) { user, error in
            print("postSignUp:\(error)")
            if let error = error {
                switch error {
                    
                case .invalidRequest:
                    self.onErrorHandling?(.invalidRequest)
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
                    self.onErrorHandling?(.internalServerError)
                }
            } else {
                // error == nil일
                print("postSignUp: OK")
                UserDefaults.standard.startMode = StartMode.main.rawValue
                self.onErrorHandling?(.ok)
            }
           
        }
    }
    
    func fetchFCMToken() {
        checkNetworking()
        AuthAPIService.fetchFCMToken()
    }
}

