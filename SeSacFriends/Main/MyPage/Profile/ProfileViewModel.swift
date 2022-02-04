//
//  ProfileViewModel.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/02/05.
//

import Foundation
import RxSwift
import RxRelay

class ProfileViewModel {
    var onErrorHandling: ((APIErrorCode) -> Void)?
    
    
    func withdrawalUser(_ completion: ((Result<Bool, APIErrorCode>) -> Void)? = nil) {
        
        SignUpAPIService.withdrawalUser { user, result  in
            
            switch result {
            case .ok:
                print("탈퇴 성공: 온보딩화면으로")
            case .notAcceptable:
                print("로그인정보가 없습니다. ->  온보딩화면으로")
                self.onErrorHandling?(.notAcceptable)
                
            default:
                self.onErrorHandling?(
                    .internalServerError)
            }
        }
    }
    
}
