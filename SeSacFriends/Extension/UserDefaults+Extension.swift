//
//  UserDefaults+Extension.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/18.
//

import Foundation
import RxSwift

enum StartMode: String {
    case onBoarding
    case auth
    case signUp
    case main
}


extension UserDefaults {
    
    private enum UserDefaultsKeys: String, CaseIterable {
        case startMode
        case authVerificationID
        case phoneNumber
        case nickname
        case birth
        case email
        case gender

    }
    


    func reset() {
        UserDefaultsKeys.allCases.forEach {
            removeObject(forKey: $0.rawValue)
        }
    }
    
    var startMode: String {
        get { string(forKey: UserDefaultsKeys.startMode.rawValue) ?? StartMode.onBoarding.rawValue}
        set { setValue(newValue, forKey: UserDefaultsKeys.startMode.rawValue)}
    }
    
    var authVerificationID: String {
        get { string(forKey: UserDefaultsKeys.authVerificationID.rawValue) ?? ""}
        set { setValue(newValue, forKey: UserDefaultsKeys.authVerificationID.rawValue)}
    }
    
    var phoneNumber: String {
        get { string(forKey: UserDefaultsKeys.phoneNumber.rawValue) ?? ""}
        set { setValue(newValue, forKey: UserDefaultsKeys.phoneNumber.rawValue)}
    }
    
    var nickname: String {
        get { string(forKey: UserDefaultsKeys.nickname.rawValue) ?? ""}
        set { setValue(newValue, forKey: UserDefaultsKeys.nickname.rawValue)}
    }
    
    var birth: String {
        get { string(forKey: UserDefaultsKeys.birth.rawValue) ?? ""}
        set { setValue(newValue, forKey: UserDefaultsKeys.birth.rawValue)}
    }
    
    var email: String {
        get { string(forKey: UserDefaultsKeys.email.rawValue) ?? ""}
        set { setValue(newValue, forKey: UserDefaultsKeys.email.rawValue)}
    }
    
    var gender: String {
        get { string(forKey: UserDefaultsKeys.gender.rawValue) ?? ""}
        set { setValue(newValue, forKey: UserDefaultsKeys.gender.rawValue)}
    }
}
