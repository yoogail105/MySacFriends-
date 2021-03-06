//
//  ResponseData.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/02/12.
//

import Foundation
import Moya

struct ResponseData<Model: Codable> {
    struct CommonResponse: Codable {
        let result: Model
    }
    
    static func processResponse(_ result: Result<Response, MoyaError>) -> Result<String?, APIErrorCode> {
        
        print("모야 Result: \(result)")
        switch result {
            
        case .success(let response):
            
            print("statusCode: \(response.statusCode)")
            let str = String(decoding: response.data, as: UTF8.self)
            print("data: \(str)")
            print("requeste: \(String(describing: response.request))")
            print("response: \(String(describing: response.response))")
            print("debug: \(response.debugDescription)")
            
            
            let statusCode = response.statusCode
            print("API Error Code: \(response.debugDescription)")
            
            
            switch statusCode {
            case APIErrorCode.ok.rawValue:
                print("성공:",response.data)
                return .success(str)
                
                // MARK: firebase error
            case APIErrorCode.unAuthorized.rawValue:
                AuthAPIService.fetchIDToken {_ in
                    print("id 토큰 새로 발급함")
                }
                return .failure(.unAuthorized)
                
            case APIErrorCode.notAcceptable.rawValue:
                //406: 미가입회원 -> 로그인 화면(번호인증화면)
                return .failure(.notAcceptable)
                
            case APIErrorCode.internalServerError.rawValue:
                return .failure(.internalServerError)
                
            case APIErrorCode.developerError.rawValue:
                return .failure(.developerError)
                
            default:
                return .failure(APIErrorCode(rawValue: statusCode ) ?? .unKnownError)
                
            }
            
        case .failure(let error):
            let statusCode = error.response?.statusCode
            print("모야 서버 통신 실패, API Error Code: \(error.errorCode)")
            
            switch statusCode {
                
            default:
                return .failure(APIErrorCode(rawValue: statusCode ?? 700) ?? .unKnownError)
            }
        }
    }
    
    // 200성공, 401, 406, 500, 501
    static func processJSONResponse(_ result: Result<Response, MoyaError>) -> Result<Model?, APIErrorCode> {
        
        switch result {
        case .success(let response):
            print("성공")
            do {
                print("statusCode: \(response.statusCode)")
                let str = String(decoding: response.data, as: UTF8.self)
                print("data: \(str)")
                print("requeste: \(String(describing: response.request))")
                print("response: \(String(describing: response.response))")
                print("debug: \(response.debugDescription)")
                
                let model = try JSONDecoder().decode(Model.self, from: response.data)
                return .success(model)
            } catch {
                print("서버 통신 실패")
                
                let statusCode = response.statusCode
                print("API Error Code: \(error)")
                
                
                switch statusCode {
                    
                    // MARK: firebase error
                case APIErrorCode.unAuthorized.rawValue:
                    AuthAPIService.fetchIDToken {_ in
                        print("토큰 새로 발급함")
                    }
                    return .failure(.unAuthorized)
                    
                case APIErrorCode.notAcceptable.rawValue:
                    return .failure(.notAcceptable)
                    
                case APIErrorCode.internalServerError.rawValue:
                    return .failure(.internalServerError)
                    
                case APIErrorCode.developerError.rawValue:
                    return .failure(.developerError)
                    
                default:
                    return .failure(APIErrorCode(rawValue: statusCode ) ?? .unKnownError)
                }
            }
            
        case .failure(let error):
            let statusCode = error.response?.statusCode
            print("모야 서버 통신 실패, API Error Code: \(error.errorCode)")
            switch statusCode {
            default:
                return .failure(APIErrorCode(rawValue: statusCode ?? 700) ?? .unKnownError)
            }
        }
    }
    
}

