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
}
