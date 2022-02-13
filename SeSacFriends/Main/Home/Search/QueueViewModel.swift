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
import RxSwift


enum SelectedGender {
    case total
    case man
    case woman
}

class QueueViewModel {
    var onErrorHandling: ((APIErrorCode) -> Void)?
    
    var totalFriends: [Friend] = []
    var requestedFriends: [Friend] = []
    var fromRecommendList: [String] = []
    
    
    var userData: Friends?
    
    var latObservable = BehaviorRelay<Double>(value: 37.517819364682694)
    var longObservable = BehaviorRelay<Double>(value: 126.88647317074734)
    
    var genderObservable = BehaviorRelay<SelectedGender>(value: .total)
    
    var matchingStatusObservable = BehaviorRelay<MatchingStatus>(value: MatchingStatus(rawValue: UserDefaults.standard.matchingStatus!) ?? .normal)
    
    func selectedGender(gender: SelectedGender) -> Int {
        switch gender {
        case .total:
            return 2
        case .man:
            return 1
        case .woman:
            return 0
        }
    }
    
    func searchFriends(_ completion: ((Result<Bool, APIErrorCode>) -> Void)? = nil) {
        
        totalFriends = []
        requestedFriends = []
        
        let selectedGender = selectedGender(gender: genderObservable.value)
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
                print("searchFriends", error)
                self.onErrorHandling?(.internalServerError)
            }
            
            switch self.genderObservable.value {
            case .total:
                for friend in friends.fromQueueDB {
                    self.totalFriends.append(contentsOf: [friend])
                }
                for requestedFriend in friends.fromQueueDBRequested {
                    self.requestedFriends.append(contentsOf: [requestedFriend])
                }
            default:
                for friend in friends.fromQueueDB {
                    if friend.gender == selectedGender {
                        self.totalFriends.append(contentsOf: [friend])
                    }
                }
                for requestedFriend in friends.fromQueueDBRequested {
                    if requestedFriend.gender == selectedGender {
                        self.requestedFriends.append(contentsOf: [requestedFriend])
                    }
                }
            }
//
//            if friends.fromQueueDB.count != 0 {
//                for friend in friends.fromQueueDB {
//                    if friend.gender == selectedGender {
//                        self.totalFriends.append(contentsOf: [friend])
//                    }
//                }
//            }
//
//            if friends.fromQueueDBRequested.count != 0 {
//                for requestedFriend in friends.fromQueueDBRequested {
//                    if requestedFriend.gender == selectedGender {
//                        self.requestedFriends.append(contentsOf: [requestedFriend])
//                    }
//                }
//            }
            print("total: \(self.totalFriends), requested: \(self.requestedFriends)")
            self.onErrorHandling?(.ok)
        }
    }
    
    
    func setFriendSesacImage(imgaeNumber: Int) -> String {
        switch imgaeNumber {
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
