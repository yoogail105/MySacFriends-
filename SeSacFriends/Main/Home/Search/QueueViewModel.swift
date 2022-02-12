//
//  SearchViewModel.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/02/10.
//

import Foundation
import RxRelay
import MapKit
import Moya


enum SelectedGender {
    case total
    case man
    case woman
}

class QueueViewModel {
    var onErrorHandling: ((APIErrorCode) -> Void)?
    
    var totalFriends: [FromQueueDB] = []
    var requestedFriends: [FromQueueDB] = []
    var fromRecommendList: [String] = []
    
    
    var userData: Friends?
    
    var latObservable = BehaviorRelay<Double>(value: 37.517819364682694)
    var longObservable = BehaviorRelay<Double>(value: 126.88647317074734)
    
    var genderObservable = BehaviorRelay<SelectedGender>(value: .woman)
    
    var matchingStatusObservable = BehaviorRelay<MatchingStatus>(value: MatchingStatus(rawValue: UserDefaults.standard.matchingStatus!) ?? .normal)
    
    func searchFriends(_ completion: ((Result<Bool, APIErrorCode>) -> Void)? = nil) {
        
        totalFriends = []
        requestedFriends = []
        let latitude = latObservable.value
        let longitude = longObservable.value
        let resultRegion = calculateRegion(lat: latitude, long: longitude)
        
        let request = OnQueueRequest(region: resultRegion, lat: latitude, long: longitude)
        
        QueueAPIService.searchHobbyFriends(param: request) { friends, error in
            guard let friends = friends else {
                return
            }
            
            switch error {
            default:
                self.onErrorHandling?(.internalServerError)
 
            }
            print("온큐에러는: \(error)")
            
            if friends.fromQueueDB.count != 0 {
                for friend in [friends.fromQueueDB] {
                    self.totalFriends.append(contentsOf: friend)
                    print("totalFriends는: \(friend)")
                }
            }
            if friends.fromQueueDBRequested.count != 0 {
                for requestedFriend in [friends.fromQueueDBRequested] {
                    self.requestedFriends.append(contentsOf: requestedFriend)
                    print("requestedFriend는: \(requestedFriend)")
                }
            }
            
            
            print("errorHandling: ok", friends)
            self.onErrorHandling?(.ok)
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
