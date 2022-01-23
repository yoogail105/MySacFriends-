//
//  APIService.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/18.
//

import Foundation
import FirebaseAuth
import CoreMedia

enum APIError: Error {
    case invalidResponse
    case noData
    case failed
    case invalidData
    case unAuthorized
}

class AuthAPIService {
    static func sendVerificationCode(phoneNumber: String, completion: @escaping () -> Void ) {
        
        PhoneAuthProvider.provider()
            .verifyPhoneNumber(phoneNumber.phoneNumberFormat(), uiDelegate: nil) { verificationID, error in
                print(phoneNumber)
                if  error != nil {
                    if let errCode = AuthErrorCode(rawValue: error!._code) {
                        
                        switch errCode {
                        case .invalidPhoneNumber:
                            print("invalid email")
                        case .missingPhoneNumber:
                            print("in use")
                        default:
                            print("Create User Error: \(error!)")
                        }
                    }
                    return
                }
                
                UserDefaults.standard.authVerificationID = verificationID!
                print("인증아이디는 \(UserDefaults.standard.authVerificationID!)")
                completion()
            }
        
    }
    
    // verificaitonCode: "AJOnW4QgBVF9FVNR6esYkz_BzpdGis9IoegIBy0ejeMTLaI42B0l36xXj3prJnhAgmQ6oBuckLYDbvVk9_hcxT_GapMAJPshiKZ_LuXoqAoex4qoAeH2H6FSnZAtDW8oPmLq_5mM9aK_GIOrDK8R-HZPL1H94Amo5sIA5apfDa2lPFD5wjo1MJn1QZEITaOKiFuBzB_zjoQxmPAVkpIcCc69EJq4PPiwXMFp4VXL2btGbeNZ798Jgkk"
    static func checkVerificationCode(verificationCode: String, completion: @escaping () -> Void) {
        
        let verificationID = UserDefaults.standard.authVerificationID!
        print("입력한 verifiacationCode는 \(verificationCode)입니다.")
        
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationID,
            verificationCode: verificationCode
        )
        
        //request
        Auth.auth().signIn(with: credential) { authResult, error in
            if let error = error {
             
                    if let errCode = AuthErrorCode(rawValue: error._code) {
                        print("check verification User Error: \(error)")
                    }
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
            completion()
            
            // ...
        }
        
        
    }
    
    static func getTokenId(completion: @escaping () ->  Void) {
        print(#function)
        let currentUser = Auth.auth().currentUser
        currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
            
            if let error = error {
                print("error: \(error)")
                return;
            }
            
            UserDefaults.standard.idToken = idToken
            print("idToken = \(String(describing: UserDefaults.standard.idToken!))")
            
            completion()
        }
    }
}