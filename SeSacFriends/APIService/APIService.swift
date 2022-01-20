//
//  APIService.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/18.
//

import Foundation
import FirebaseAuth

enum APIError: Error {
    case invalidResponse
    case noData
    case failed
    case invalidData
    case unAuthorized
}

class APIService {
    
    static func sendVerificationCode(phoneNumber: String, completion: @escaping () -> Void ) {
        
        
        PhoneAuthProvider.provider()
            .verifyPhoneNumber(phoneNumber.phoneNumberFormat(), uiDelegate: nil) { verificationID, error in
                if let error = error {
                    print("authError:", error.localizedDescription)
                         // self.showMessagePrompt(error.localizedDescription)
                    return
                }
                Auth.auth().languageCode = "kr"
                UserDefaults.standard.authVerificationID = verificationID!
                print("인증아이디는 \(verificationID)")
                completion()
            }
    }
    
    static func checkVerificationCode(verificationCode: String) {
        let verificationID = UserDefaults.standard.authVerificationID
    

            let credential = PhoneAuthProvider.provider().credential(
              withVerificationID: verificationID,
              verificationCode: verificationCode
            )

            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                  let authError = error as NSError
                  if authError.code == AuthErrorCode.secondFactorRequired.rawValue {
                    // The user is a multi-factor user. Second factor challenge is required.
                    let resolver = authError
                      .userInfo[AuthErrorUserInfoMultiFactorResolverKey] as! MultiFactorResolver
                    var displayNameString = ""
                    for tmpFactorInfo in resolver.hints {
                      displayNameString += tmpFactorInfo.displayName ?? ""
                      displayNameString += " "
                    }
                  } else {
                      print("인증번호 인증 에러: ", error.localizedDescription)
                      //self.showMessagePrompt(error.localizedDescription)
                    return
                  }
                  // ...
                  return
                }
                // User is signed in

                print("로그인 완료!")
                // ...
            }


    }
    
}
