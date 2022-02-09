//
//  SearchViewModel.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/02/10.
//

import Foundation
import RxRelay

class SearchViewModel {
    var onErrorHandling: ((APIErrorCode) -> Void)?
    
    var regionObserval = BehaviorRelay<Int>(value: 1274830692)
    var latObserval = BehaviorRelay<Double>(value: 37.482733667903865)
    var longObserval = BehaviorRelay<Double>(value: 126.92983890550006)
    
    // region, lat, long
    func searchFriends(_ completion: ((Result<Bool, APIErrorCode>) -> Void)? = nil) {
        QueueAPIService.searchFriends(region:regionObserval.value, lat: latObserval.value, long: longObserval.value) { user, result in
            switch result {
            case .ok:
                self.onErrorHandling?(.ok)
                return
            default:
                self.onErrorHandling?(.internalServerError)
            }
        }
        
    }
}
