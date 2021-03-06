//
//  ProfileViewModel.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/02/05.
//

import Foundation
import RxSwift
import RxRelay
import Pageboy


class ProfileViewModel {
    var onErrorHandling: ((APIErrorCode) -> Void)?
    
    var menuTitles = ["","공지사항", "자주 묻는 질문", "1:1 문의", "알림 설정", "이용 약관"]
    
    var profileData = (searchable: 1,
                       ageMin:18,
                       ageMax: 20,
                       gender: 1,
                       hobby: "Codingding",
                       reputation: [0, 0, 0, 0, 0, 0, 0, 0, 0])

    
    var searchableObserver = BehaviorRelay<Int>(value: 0)
    var genderObserver = BehaviorRelay<Int>(value: 0)
    var hobbyObserer = BehaviorRelay<String>(value: "")
    var lowerValueObserver = BehaviorRelay<Int>(value: 18)
    var upperValueObserver = BehaviorRelay<Int>(value: 65)
    
    func checkNetworking() {
        if !NetworkMonitor.shared.isConnected {
            self.onErrorHandling?(.networkError)
            return
        }
    }
    
    // MARK: APIService
    
    func getUser(_ completion: ((Result<Bool, APIErrorCode>) -> Void)? = nil) {
        checkNetworking()
        
        UserAPIService.login { user, error in
            if error != nil {
            switch error {
            case .notAcceptable:
                print("getUser: notAcceptable")
                UserDefaults.standard.startMode = StartMode.signUp.rawValue
                self.onErrorHandling?(.notAcceptable)
                
            case .unAuthorized:
                self.getUser()
                self.onErrorHandling?(.unAuthorized)
                
            default:
                print("getUser: internalServerError")
                self.onErrorHandling?(.internalServerError)
            }
            }
            
            guard let user = user else {
                return
            }
            self.profileData.searchable = user.searchable
            self.profileData.ageMin = user.ageMin
            self.profileData.ageMax = user.ageMax
            self.profileData.gender = user.gender
            self.profileData.hobby = user.hobby
            self.profileData.reputation = user.reputation
            
            if user.FCMtoken != UserDefaults.standard.FCMToken! {
                
            }
            print("profiledata는 :", self.profileData)
            self.onErrorHandling?(.ok)
        }
    }
    
    func updateFCMToken( _ completion: ((Result<Bool, APIErrorCode>) -> Void)? = nil) {
    
        checkNetworking()
        
        let request = UpdateFCMToken(FCMtoken: UserDefaults.standard.FCMToken!)
        
        UserAPIService.updateFCMToken(param: request) { result, error in
            if let error = error {
                switch error {
                default:
                    self.onErrorHandling?(.internalServerError)
                }
            } else {
                print("fcm토큰 갱신 성공")
            }
        }
    }
    
   
    
    func updateMypage( _ completion: ((Result<Bool, APIErrorCode>) -> Void)? = nil) {
    
        checkNetworking()
        
        let request = UpdateMyPageRequest(searchable: searchableObserver.value, ageMin: profileData.ageMin, ageMax: profileData.ageMax, gender: genderObserver.value, hobby: hobbyObserer.value)
        print("updateMypgae:\(request)")
        UserAPIService.updateMyPage(param: request) { result, error in
            
    
            if let error = error {
                print("error")
                switch error {
                case .unAuthorized:
                    self.onErrorHandling?(.unAuthorized)
                    self.updateMypage()
                case .notAcceptable:
                    self.onErrorHandling?(.notAcceptable)
                default:
                    self.onErrorHandling?(.internalServerError)
                }
                
            } else {
                print("성공")
                UserDefaults.standard.searchable = self.searchableObserver.value
                UserDefaults.standard.gender = self.genderObserver.value
                UserDefaults.standard.hobby = self.hobbyObserer.value
                self.onErrorHandling?(.ok)
            }
            
            

        }
    }
    
    func withdrawalUser(_ completion: ((Result<Bool, APIErrorCode>) -> Void)? = nil) {
        checkNetworking()
        
        UserAPIService.withdrawalUser { user, error  in
            if let error = error {
            switch error {
           
            case .notAcceptable:
                print("로그인정보가 없습니다. ->  온보딩화면으로")
                UserDefaults.standard.startMode = StartMode.onBoarding.rawValue
                self.onErrorHandling?(.notAcceptable)
            default:
                let error = String(describing: error)
                print("알 수 없는 error: \(error)")
                self.onErrorHandling?(.internalServerError)
            }
            } else {
                AuthAPIService.deleteUserAuth {
                    print("파이어베이스 사용자 삭제 성공")
                }
                UserDefaults.standard.reset()
                UserDefaults.standard.startMode = StartMode.onBoarding.rawValue
                print("탈퇴:\(UserDefaults.standard.nickname)")
                print("탈퇴 성공: 온보딩화면으로")
                self.onErrorHandling?(.ok)
            }
        }
    }
    
}
