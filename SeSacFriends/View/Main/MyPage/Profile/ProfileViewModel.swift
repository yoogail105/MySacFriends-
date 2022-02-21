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
                       hobby: "Codingding")

    
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
            print("profiledata는 :", self.profileData)
            self.onErrorHandling?(.ok)
        }
    }
    
    func getUser2(_ completion: ((Result<Bool, APIErrorCode>) -> Void)? = nil) {
        checkNetworking()
        UserAPIService.login { user, result  in
            
                switch result {
                    
                case .ok:
                    self.profileData.searchable = user?.searchable ?? 0
                    self.profileData.ageMin = user?.ageMin ?? 18
                    self.profileData.ageMax = user?.ageMax ?? 65
                    self.profileData.gender = user?.gender ?? UserDefaults.standard.gender
                    self.profileData.hobby = user?.hobby ?? ""
                    print("profiledata는 :", self.profileData)
                    
                    self.onErrorHandling?(.ok)
                    
                case .notAcceptable:
                    print("getUser: notAcceptable")
                    UserDefaults.standard.startMode = StartMode.signUp.rawValue
                    self.onErrorHandling?(.notAcceptable)
                    
                default:
                    print("getUser: internalServerError")
                    self.onErrorHandling?(.internalServerError)
                }
        }
    }
    
    func updateMypage( _ completion: ((Result<Bool, APIErrorCode>) -> Void)? = nil) {
        checkNetworking()
        UserAPIService.updateMyPage(searchable: searchableObserver.value, ageMin: profileData.ageMin, ageMax: profileData.ageMax, gender: genderObserver.value, hobby: hobbyObserer.value) { user, result in
            //print(result)
            guard result != nil else {
                return
            }
            print("저장 성공했습니다.")
            
            UserDefaults.standard.searchable = self.searchableObserver.value
            UserDefaults.standard.gender = self.genderObserver.value
            UserDefaults.standard.hobby = self.hobbyObserer.value

        }
    }
    
    func withdrawalUser(_ completion: ((Result<Bool, APIErrorCode>) -> Void)? = nil) {
        checkNetworking()
        UserAPIService.withdrawalUser { user, result  in
            
            switch result {
            case .ok:
                AuthAPIService.deleteUserAuth {
                    print("파이어베이스 사용자 삭제 성공")
                }
                UserDefaults.standard.reset()
                UserDefaults.standard.startMode = StartMode.onBoarding.rawValue
                print("탈퇴:\(UserDefaults.standard.nickname)")
                print("탈퇴 성공: 온보딩화면으로")
                self.onErrorHandling?(.ok)
            case .notAcceptable:
                print("로그인정보가 없습니다. ->  온보딩화면으로")
                UserDefaults.standard.startMode = StartMode.onBoarding.rawValue
                self.onErrorHandling?(.notAcceptable)
            default:
                let error = String(describing: result)
                print("알 수 없는 error: \(error)")
            }
        }
    }
    
}
