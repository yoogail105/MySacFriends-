//
//  SearchViewModel.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/02/10.
//

import Foundation
import RxRelay

class QueueViewModel {
    var onErrorHandling: ((APIErrorCode) -> Void)?
    
    var regionObservable = BehaviorRelay<Int>(value: 1274830692)
    var latObservable = BehaviorRelay<Double>(value: 37.482733667903865)
    var longObservable = BehaviorRelay<Double>(value: 126.92983890550006)
    
//    {
//      "region": 1274830692,
//      "lat": 37.482733667903865,
//      "long": 126.92983890550006
//    }
    
    // region, lat, long
    func searchFriends(_ completion: ((Result<Bool, APIErrorCode>) -> Void)? = nil) {
        
        let latitude = latObservable.value
        let longitude = longObservable.value
        let resultRegion = calculateRegion(lat: latitude, long: longitude)
        
        QueueAPIService.searchFriends(region:1274830692, lat: 37.482733667903865, long: 126.92983890550006) {
            
            
            user, result in
            switch result {
            case .ok:
                self.onErrorHandling?(.ok)
                return
            default:
                self.onErrorHandling?(.internalServerError)
            }
        }
        
    }
    
    // 10자리로 변환하는 함수
    func calculateRegion(lat: Double, long: Double) -> Int {
        print("0. latitudeString: \(lat), longitudeString: \(long)")
        var latitudeString = String(lat + 90.0)
        var longitudeString = String(long + 180.0)
        latitudeString = latitudeString.replacingOccurrences(of: ".", with: "")
        longitudeString = longitudeString.replacingOccurrences(of: ".", with: "")
        
        let region = "\(latitudeString.prefix(5))\(longitudeString.prefix(5))"
        print("region:",region)

        return Int(region)!
    }
}
