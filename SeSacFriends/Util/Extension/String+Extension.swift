//
//  String+Extension.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/18.
//

import Foundation

extension String {
    
    
    func phoneNumberFormat() -> String {
        let startIdx: String.Index = self.index(self.startIndex, offsetBy: 1)
        var result = String(self[startIdx...])
        result =  result.replacingOccurrences(of: "-", with: "")
        print("저장된 폰넘버: ", result)
        return "+82\(result)"
    }
    
    func addHyphen() -> String {
        let _str = self.replacingOccurrences(of: "-", with: "")
        let arr = Array(_str)
        if arr.count > 3 {
            if let regex = try? NSRegularExpression(pattern: "([0-9]{3})([0-9]{3,4})([0-9]{4})", options: .caseInsensitive) {
                let modString = regex.stringByReplacingMatches(in: _str, options: [], range: NSRange(_str.startIndex..., in: _str), withTemplate: "$1-$2-$3")
                return modString
                
            }
            
        }
        return self
    }
    
    
    func validatePhoneNumber() -> Bool {
        let phoneNumberRegex = "^01([0-9])+-([0-9]{3,4})+-([0-9]{4})$"
        let predicate = NSPredicate(format:"SELF MATCHES %@", phoneNumberRegex)
        return predicate.evaluate(with: self)
    }
    
    func validateEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return predicate.evaluate(with: self)
    }
    
    func validatePassword() -> Bool {
        let passwordRegex = "^(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z])(?=.*[~!@#$%^&*]).{8,15}$"
        let predicate = NSPredicate(format:"SELF MATCHES %@", passwordRegex)
        return predicate.evaluate(with: self)
    }
    
    func isValidCertificationCode() -> Bool {
        let certificationCodeRegex = "^[0-9]{6}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", certificationCodeRegex)
        return predicate.evaluate(with: self)
    }
    
}
