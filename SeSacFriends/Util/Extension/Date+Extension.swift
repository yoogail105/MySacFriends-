//
//  DateFormatter+Extension.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/25.
//

import Foundation

extension Date {
    
    func birthFormat() -> String {
        let daterFormatter = DateFormatter()
        daterFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        return daterFormatter.string(from: self)
    }
    
}
