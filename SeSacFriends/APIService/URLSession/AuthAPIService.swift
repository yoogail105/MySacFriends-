//
//  APIService.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/18.
//

import Foundation
import FirebaseAuth
import CoreMedia



class AuthAPIService {
    static func sendVerificationCode(phoneNumber: String, completion: @escaping (APIErrorMessage?) -> Void ) {
        
        PhoneAuthProvider.provider()
            .verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationID, error in
                print(phoneNumber)
                if  error != nil {
                    if let errCode = AuthErrorCode(rawValue: error!._code) {
                        
                        switch errCode {
                            
                        case .tooManyRequests:
                            completion(.tooManyRequests)
                            print("너무 많은 요청")
                        default:
                            print("Create User Error: \(error!)")
                            completion(.failed)
                        }

                    }
                    return
                }
                
                UserDefaults.standard.authVerificationID = verificationID!
                completion(nil)
            }
        
    }
    
    
    static func checkVerificationCode(verificationCode: String, completion: @escaping (APIErrorCode?) -> Void) {
        
        let verificationID = UserDefaults.standard.authVerificationID!
        print("입력한 verifiacationCode는 \(verificationCode)입니다.")
        
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationID,
            verificationCode: verificationCode
        )
        
        //request
        Auth.auth().signIn(with: credential) { authResult, error in
            if let error = error {
                completion(.verificationCodeError)
             
                    if let _ = AuthErrorCode(rawValue: error._code) {
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
                    return
                }
                return
            }
            
            UserDefaults.standard.startMode = StartMode.signUp.rawValue
            completion(.ok)
        }
    }
    
    //firebase idtocken발급
    static func fetchIDToken(completion: @escaping (APIErrorCode?) ->  Void) {
        print(#function)
        let currentUser = Auth.auth().currentUser
        currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
            if let error = error {
                completion(.unAuthorized)
                print("fetchIDTocken error: \(error)")
                return
            }
            
            UserDefaults.standard.idToken = idToken
            completion(.ok)
        }
    }

    // 사용자 삭제
    static func deleteUserAuth(completion: @escaping () ->  Void) {
        let user = Auth.auth().currentUser
        
        user?.delete { error in
            if error != nil {
                // An error happened.
            } else {
                completion()
            }
        }
        
    }


   static func fetchUserData(completion: @escaping () -> Void) {
       
        Auth.auth().addStateDidChangeListener { auth, user in

            if user != nil {
                //로그인 된 상태
                print("로그인 되어있음")
            } else {
                //로그인 안된상태
                print("로그인 되어있지 않음")
            }
        //let currentUid = Auth.auth().currentUser?.uid
        //guard let currentUid = currentUid else { return }
        
            completion()
        }
   }


}
