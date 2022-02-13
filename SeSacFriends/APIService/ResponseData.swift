//
//  ResponseData.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/02/12.
//

import Foundation
import Moya

//static func defaultErrorHandling(_ result: MoyaError) -> APIErrorCode) {
//    switch result {
//    case .failure(let error):
//    default:
//        return
//    }
//    
//}

struct ResponseData<Model: Codable> {
    struct CommonResponse: Codable {
        let result: Model
    }
    
    static func processResponse(_ result: Result<Response, MoyaError>) -> Result<Model?, APIErrorCode> {
        switch result {
            
        case .success(let response):
            return .success(nil)
            
        case .failure(let error):
            let statusCode = error.response?.statusCode
            print("API Error Code: \(error.errorCode)")
            
            switch statusCode {
                
            // MARK: firebase error
            case APIErrorCode.unAuthorized.rawValue:
                AuthAPIService.fetchIDToken {
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
                return .failure(APIErrorCode(rawValue: statusCode!) ?? .developerError)
            }
        }
    }
    
    // 200성공, 401, 406, 500, 501
    static func processJSONResponse(_ result: Result<Response, MoyaError>) -> Result<Model?, APIErrorCode> {
        switch result {
            
        case .success(let response):
            do {
                let model = try JSONDecoder().decode(Model.self, from: response.data)
                return .success(model)
            } catch {
                return .failure(.decodableError)
            }
            
        case .failure(let error):
            let statusCode = error.response?.statusCode
            print("API Error Code: \(error.response?.statusCode)")
            
            switch statusCode {
                
            // MARK: firebase error
            case APIErrorCode.unAuthorized.rawValue:
                AuthAPIService.fetchIDToken {
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
                return .failure(APIErrorCode(rawValue: statusCode! ?? 501)!)
            }
        }
    }
}


