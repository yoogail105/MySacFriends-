//
//  ProfileViewModel.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/02/05.
//

import Foundation
import RxSwift
import RxRelay

struct ProfileData {
    var searchable: Int
    var ageMin: Int
    var ageMax: Int
    var gender: Int
    var hobby: String
}

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
    
    
    func getUser(_ completion: ((Result<Bool, APIErrorCode>) -> Void)? = nil) {
        UserAPIService.login { user, result  in
            
                switch result {
                    
                case .ok:
                    self.profileData.searchable = user?.searchable! ?? 0
                    self.profileData.ageMin = user?.ageMin! ?? 18
                    self.profileData.ageMax = user?.ageMax! ?? 65
                    self.profileData.gender = user?.gender! ?? UserDefaults.standard.gender
                    self.profileData.hobby = user?.hobby! ?? ""
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

        UserAPIService.updateMyPage(searchable: profileData.searchable, ageMin: profileData.ageMin, ageMax: profileData.ageMax, gender: genderObserver.value, hobby: hobbyObserer.value) { user, result in
            print(result)
            guard let result = result else {
                return
            }
            print("저장 성공했습니다.")

        }
    }
    
    func withdrawalUser(_ completion: ((Result<Bool, APIErrorCode>) -> Void)? = nil) {
        
        UserAPIService.withdrawalUser { user, result  in
            
            switch result {
            case .ok:
                print("탈퇴 성공: 온보딩화면으로")
            case .notAcceptable:
                print("로그인정보가 없습니다. ->  온보딩화면으로")
                self.onErrorHandling?(.notAcceptable)
                
            default:
                self.onErrorHandling?(
                    .internalServerError)
            }
        }
    }
    
}
