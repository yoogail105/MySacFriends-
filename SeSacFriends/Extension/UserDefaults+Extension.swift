//
//  UserDefaults+Extension.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/18.
//

import Foundation

extension UserDefaults {
    private enum UserDefaultsKeys: String, CaseIterable {
        case authVerificationID
      

    }
    
    func reset() {
        UserDefaultsKeys.allCases.forEach {
            removeObject(forKey: $0.rawValue)
        }
    }
    
    var authVerificationID: String {
        get { string(forKey: UserDefaultsKeys.authVerificationID.rawValue) ?? ""}
        set { setValue(newValue, forKey: UserDefaultsKeys.authVerificationID.rawValue)}
    }
}
