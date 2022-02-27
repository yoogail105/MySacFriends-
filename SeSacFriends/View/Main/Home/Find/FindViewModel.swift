//
//  FindViewModel.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/02/27.
//

import Foundation
import Moya

class FindViewModel {
    
    var onErrorHandling: ((APIErrorCode) -> Void)?
    weak var coordinator: HomeCoordinator?
    
    func stopFinding(_ completion: ((Result<Bool, APIErrorCode>) -> Void)? = nil) {
        
        QueueAPIService.stopSearchFriends { result, error in
            
            if let error = error {
                switch error {
                case .created:
                    self.onErrorHandling?(.created)
                case .notAcceptable:
                    self.onErrorHandling?(.notAcceptable)
                case .unAuthorized:
                    self.stopFinding()
                    self.onErrorHandling?(.unAuthorized)
                default:
                    self.onErrorHandling?(.internalServerError)
                }
            } else {
                self.onErrorHandling?(.ok)
            }
            
        }
        
    }
    
    
    
}



