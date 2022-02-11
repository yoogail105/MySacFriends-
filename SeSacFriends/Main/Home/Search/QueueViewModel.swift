//
//  SearchViewModel.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/02/10.
//

import Foundation
import RxRelay
import MapKit


enum SelectedGender {
    case total
    case man
    case woman
}

class QueueViewModel {
    var onErrorHandling: ((APIErrorCode) -> Void)?
    
    
    var latObservable = BehaviorRelay<Double>(value: 37.517819364682694)
    var longObservable = BehaviorRelay<Double>(value: 126.88647317074734)
    
    let manButtonObservable = PublishRelay<Void>()
    let womanButtonObservable = PublishRelay<Void>()
    let allButtonObservable = PublishRelay<Void>()
    
    var genderObservable = BehaviorRelay<SelectedGender>(value: .woman)
    
    var totalFriends: [FromQueueDB?] = []
    var requestedFriends: [FromQueueDB] = []
    
    func searchFriends(_ completion: ((Result<Bool, APIErrorCode>) -> Void)? = nil) {
        totalFriends = []
        requestedFriends = []
        let latitude = latObservable.value
        let longitude = longObservable.value
        let resultRegion = calculateRegion(lat: latitude, long: longitude)
        
        QueueAPIService.searchFriends(region:resultRegion, lat: latitude, long: longitude) { user, result in
            switch result {
            case .ok:
                if user?.fromQueueDB.count == 0 {

                } else {
                    for friend in [user?.fromQueueDB] {
                        self.totalFriends.append(contentsOf: friend!)
                        print("totalFriends는: \(friend!)")
                    }
                }

                
                if user?.fromQueueDBRequested.count == 0 {
                    
                } else {
                    for requestedFriend in [user?.fromQueueDBRequested] {
                        self.requestedFriends.append(contentsOf: requestedFriend!)
                        print("requestedFriend는: \(requestedFriend!)")
                    }
                }
                self.onErrorHandling?(.ok)
                
                
            default:
                self.onErrorHandling?(.internalServerError)
            }
        }
    }
    
    func setFriendSesacImage(friend: FromQueueDB) -> String {
        switch friend.sesac {
        case 1:
            return SesacIcon.face1.rawValue
        case 2:
             return SesacIcon.face2.rawValue
        case 3:
            return SesacIcon.face3.rawValue
        case 4:
            return  SesacIcon.face4.rawValue
        default:
            return SesacIcon.face0.rawValue
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
