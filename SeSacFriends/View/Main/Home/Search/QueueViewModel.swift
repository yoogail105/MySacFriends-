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
import RxCocoa
import AVFoundation


enum SelectedGender {
    case total
    case man
    case woman
}

class QueueViewModel {
    var onErrorHandling: ((APIErrorCode) -> Void)?
    
    var totalFriends: [Friend] = []
    var nearFriendsObserver = BehaviorRelay<[Friend]>(value: [Friend]())
    var requestedFriendsObserver = BehaviorRelay<[Friend]>(value: [Friend]())
    var isUpdate = BehaviorRelay<Bool>(value: false)
    var nearFriends: [Friend] = []
    var requestedFriends: [Friend] = []
    var fromRecommendHobbyList: [String] = []
    var friendsHobbyList: [String] = []
    var myHobbyList: [String] = []
    
    let disposeBag = DisposeBag()
    
    var userData: Friends?
    var myStatus: MyQueueState?
    
    var currentLatitude = 37.51781675120152
    var currentLongitude = 126.92983890550006
    var genderObservable = BehaviorRelay<SelectedGender>(value: .total)
    
    var matchingStatusObservable = BehaviorRelay<MatchingStatus>(value: MatchingStatus(rawValue: UserDefaults.standard.matchingStatus!) ?? .normal)
    
    
    //var subject: BehaviorRelay<[HobbySection]> = BehaviorRelay(value: [])
    func checkNetworking() {
        if !NetworkMonitor.shared.isConnected {
            self.onErrorHandling?(.networkError)
            return
        }
    }
    
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
    
    func searchMatchedFriends(_ completion: ((Result<Bool, APIErrorCode>) -> Void)? = nil) {
        checkNetworking()
        print(#function)
        nearFriends = []
        requestedFriends = []
        isUpdate.accept(false)
        self.removeData(observer: nearFriendsObserver)
        self.removeData(observer: requestedFriendsObserver)
        
        let resultRegion = calculateRegion(lat: currentLatitude, long: currentLongitude)
        let request = OnQueueRequest(region: resultRegion, lat: currentLatitude, long: currentLongitude)
        print(request)
        
        QueueAPIService.searchHobbyFriends(param: request) { friends, error in
            
            if let error = error {
                // error != nil
                print("error \(error)")
            }
            
            if let friends = friends {
                for friend in friends.fromQueueDB {
                    // self.totalFriends.append(contentsOf: [friend])
                    self.myHobbyList.forEach {
                        if friend.hf.contains($0) {
                            self.nearFriendsObserver
                                .accept(self.nearFriendsObserver.value + [friend])
                            self.nearFriends.append(friend)
                            print(friend.nick)
                            return
                        }
                    }
                }
                
                for requestedFriend in friends.fromQueueDBRequested {
                    print("requestedFriend: \(requestedFriend)")
                    self.requestedFriendsObserver
                        .accept(self.requestedFriendsObserver.value + [requestedFriend])
                    self.requestedFriends.append(contentsOf: [requestedFriend])
                }
                
                print("myHobby: \(self.myHobbyList), nearBy: \(self.nearFriends), received: \(self.requestedFriends)")
            }
            
            self.isUpdate.accept(true)
            self.onErrorHandling?(.ok)
        }
    }
    
    
    
    //onqueue
    func searchFriends(_ completion: ((Result<Bool, APIErrorCode>) -> Void)? = nil) {
        checkNetworking()
        print(#function)
        totalFriends = []
        requestedFriends = []
        fromRecommendHobbyList = []
        friendsHobbyList = []
        
        let selectedGender = selectedGender(gender: genderObservable.value)
        let resultRegion = calculateRegion(lat: currentLatitude, long: currentLongitude)
        let request = OnQueueRequest(region: resultRegion, lat: currentLatitude, long: currentLongitude)
        print("searchFriends request:", request)
        
        QueueAPIService.searchHobbyFriends(param: request) { friends, error in
            
            if error != nil {
                switch error {
                case .unAuthorized:
                    self.onErrorHandling?(.unAuthorized)
                default:
                    self.onErrorHandling?(.internalServerError)
                    print("error: \(error)")
                    
                }
            }
            
            guard let friends = friends else {
                return
            }
            
            print("searchHobbyFriends:", friends)
            for hobby in friends.fromRecommend {
                if hobby != "" {
                    self.fromRecommendHobbyList.append(contentsOf: [hobby])
                }
            }
            
            switch self.genderObservable.value {
            case .total:
                for friend in friends.fromQueueDB {
                    self.totalFriends.append(contentsOf: [friend])
                    for hobby in friend.hf {
                        if hobby != "" {
                        if !self.friendsHobbyList.contains(hobby){
                            self.friendsHobbyList.append(hobby)
                        }
                        }
                    }
                    
                }
                for requestedFriend in friends.fromQueueDBRequested {
                    self.requestedFriends.append(contentsOf: [requestedFriend])
                    for hobby in requestedFriend.hf {
                        if hobby != "" {
                        self.friendsHobbyList.append(hobby)
                        }
                    }
                }
            default:
                for friend in friends.fromQueueDB {
                    if friend.gender == selectedGender {
                        self.totalFriends.append(contentsOf: [friend])
                        for hobby in friend.hf {
                            if hobby != "" {
                            self.friendsHobbyList.append(hobby)
                            }
                        }
                    }
                }
                for requestedFriend in friends.fromQueueDBRequested {
                    if requestedFriend.gender == selectedGender {
                        self.requestedFriends.append(contentsOf: [requestedFriend])
                        for hobby in requestedFriend.hf {
                            if hobby != "" {
                            self.friendsHobbyList.append(hobby)
                            }
                        }
                    }
                }
            }
            self.onErrorHandling?(.ok)
        }
    }
    
    
    
    func requestFindHobbyFriends(_ completion: ((Result<Bool, APIErrorCode>) -> Void)? = nil) {
        checkNetworking()
        
        let latitude = currentLatitude
        let longitude = currentLongitude
        let resultRegion = calculateRegion(lat: latitude, long: longitude)
        
        let request = QueueRequest(type: 2, region: resultRegion, long: longitude, lat: latitude, hf: self.myHobbyList)
        print(request)
        QueueAPIService.requestFindHobbyFriends2( param: request, completion: {result, error in
            
            if error != nil {
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
            } else {
                UserDefaults.standard.matchingStatus = MatchingStatus.ing.rawValue
                self.onErrorHandling?(.ok)
                return
            }
        })
    }
    
    func requestTogether(uid: String, _ completion: ((Result<Bool, APIErrorCode>) -> Void)? = nil) {
        checkNetworking()
        
        let request = HobbyRequest(otheruid: uid)
        QueueAPIService.requestTogether(param: request) { result, error in
            if error != nil {
                switch error?.rawValue {
                case 201:
                    print("상대방이 이미 나에게 요청했음")
                    self.onErrorHandling?(.created)
                    return
                case 202:
                    print("상대방이 찾기 중단")
                    self.onErrorHandling?(.invalidRequest)
                    return
                case 401:
                    print("토큰만료됨")
                    self.onErrorHandling?(.unAuthorized)
                    return
                case 406:
                    print("미가입회원")
                    self.onErrorHandling?(.notAcceptable)
                    return
                default:
                    self.onErrorHandling?(.internalServerError)
                    return
                }
            } else {
                print("요청완료")
                    self.onErrorHandling?(.ok)
            }
        }
    }
    
    func acceptTogether(uid: String, _ completion: ((Result<Bool, APIErrorCode>) -> Void)? = nil) {
        checkNetworking()
        
        let request = HobbyRequest(otheruid: uid)
        QueueAPIService.acceptTogether(param: request) { result, error in
            if error != nil {
                switch error?.rawValue {
                case 201:
                    print("상대방이 이미 다른사람과 매칭됨")
                    self.onErrorHandling?(.created)
                    return
                case 202:
                    print("상대방이 같이하기 중단")
                    self.onErrorHandling?(.invalidRequest)
                    return
                case 203:
                    print("앗! 누군가가 나의 취미 함께 하기를 수락하였어요! myQueuestate호출")
                    self.onErrorHandling?(.firstPenalty)
                    return
                    
                case 401:
                    print("토큰만료됨")
                    self.onErrorHandling?(.unAuthorized)
                    return
                case 406:
                    print("미가입회원")
                    self.onErrorHandling?(.notAcceptable)
                    return
                default:
                    self.onErrorHandling?(.internalServerError)
                    return
                }
            } else {
                print("수락완료")
                    self.onErrorHandling?(.ok)
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
    
    func checkUserStatus(_ completion: ((Result<Bool, APIErrorCode>) -> Void)? = nil) {
        checkNetworking()
        
        QueueAPIService.myQueueStatus { result, error in
            
            if error != nil {
                switch error?.rawValue {
                case 201:
                    UserDefaults.standard.matchingStatus = MatchingStatus.normal.rawValue
                    self.onErrorHandling?(.created)
                    return
                case 401:
                    print("토큰만료됨")
                    self.onErrorHandling?(.unAuthorized)
                    return
                case 406:
                    print("미가입회원")
                    self.onErrorHandling?(.notAcceptable)
                    return
                default:
                    self.onErrorHandling?(.internalServerError)
                    return
                }
            } else {
                self.myStatus = result
                UserDefaults.standard.matchingStatus = MatchingStatus.done.rawValue
                self.onErrorHandling?(.ok)
            }
        }
    }
    
    // 10자리로 변환하는 함수
    func calculateRegion(lat: Double, long: Double) -> Int {
        var latitudeString = String(lat + 90.0)
        var longitudeString = String(long + 180.0)
        latitudeString = latitudeString.replacingOccurrences(of: ".", with: "")
        longitudeString = longitudeString.replacingOccurrences(of: ".", with: "")
        
        let region = "\(latitudeString.prefix(5))\(longitudeString.prefix(5))"
        
        return Int(region)!
    }
    
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
                UserDefaults.standard.matchingStatus = MatchingStatus.normal.rawValue
                self.onErrorHandling?(.ok)
            }
            
        }
        
    }
    
    func removeData(observer: BehaviorRelay<[Friend]>) {
        var array = observer.value
        array.removeAll()
        observer.accept(array)
    }
    
}
