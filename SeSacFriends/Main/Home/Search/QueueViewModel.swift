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
    
    
    var fromRecommendHobbyList: [String] = []
    var friendsHobbyList: [String] = []
    var myHobbyList: [String] = []
    var friendsHobbyListOb: Observable<[String]>?
    
    
    
    let disposeBag = DisposeBag()
    
    var userData: Friends?
    
    var latObservable = BehaviorRelay<Double>(value: 37.517819364682694)
    var longObservable = BehaviorRelay<Double>(value: 126.88647317074734)
    
    var genderObservable = BehaviorRelay<SelectedGender>(value: .total)
    
    var matchingStatusObservable = BehaviorRelay<MatchingStatus>(value: MatchingStatus(rawValue: UserDefaults.standard.matchingStatus!) ?? .normal)
    
    
    //var subject: BehaviorRelay<[HobbySection]> = BehaviorRelay(value: [])
    
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
        fromRecommendHobbyList = []
        friendsHobbyList = []
        myHobbyList = []
        
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
                //print("searchFriends", error)
                self.onErrorHandling?(.internalServerError)
            }
            
            print(friends)
            for hobby in friends.fromRecommend {
                self.fromRecommendHobbyList.append(contentsOf: [hobby])
            }
            
            switch self.genderObservable.value {
            case .total:
                for friend in friends.fromQueueDB {
                    self.totalFriends.append(contentsOf: [friend])
                    for hobby in friend.hf {
                        self.friendsHobbyList.append(hobby)
                    }
                    
                }
                for requestedFriend in friends.fromQueueDBRequested {
                    self.requestedFriends.append(contentsOf: [requestedFriend])
                    for hobby in requestedFriend.hf {
                        self.friendsHobbyList.append(hobby)
                    }
                }
            default:
                for friend in friends.fromQueueDB {
                    if friend.gender == selectedGender {
                        self.totalFriends.append(contentsOf: [friend])
                        for hobby in friend.hf {
                            self.friendsHobbyList.append(hobby)
                        }
                    }
                }
                for requestedFriend in friends.fromQueueDBRequested {
                    if requestedFriend.gender == selectedGender {
                        self.requestedFriends.append(contentsOf: [requestedFriend])
                        for hobby in requestedFriend.hf {
                            self.friendsHobbyList.append(hobby)
                        }
                    }
                }
            }
            
            self.onErrorHandling?(.ok)
        }
    }
    
    func requestFindHobbyFriends(_ completion: ((Result<Bool, APIErrorCode>) -> Void)? = nil) {
        
        //        let latitude = latObservable.value
        //        let longitude = longObservable.value
        //        let resultRegion = calculateRegion(lat: latitude, long: longitude)
        //
        //        let request = QueueRequest(type: 2, region: resultRegion, lat: latitude, long: longitude, hf: self.myHobbyList)
        //        QueueAPIService.requestFindHobbyFriends2(param: request, completion: {friends, error in
        QueueAPIService.requestFindHobbyFriends { result, error in
            
            if error == nil {
                self.onErrorHandling?(.ok)
            }
            
            switch error?.rawValue {
            case 201:
                self.onErrorHandling?(.created)
                return
            case 203:
                self.onErrorHandling?(.firstPenalty)
                return
            case 204:
                self.onErrorHandling?(.secondPenalty)
                return
            case 205:
                self.onErrorHandling?(.finalPenalty)
                return
            case 206:
                self.onErrorHandling?(.emptyGender)
                return
            default:
                self.onErrorHandling?(.internalServerError)
                return
            }
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
