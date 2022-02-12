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

    static func processResponse(_ result: Result<Response, MoyaError>) -> Result<Model, Error> {
        switch result {
        case .success(let response):
            do {
                
                _ = try response.filterSuccessfulStatusCodes()

                let commonResponse = try JSONDecoder().decode(CommonResponse.self, from: response.data)
                print("processResponse:", commonResponse.result)
                return .success(commonResponse.result)
                
            } catch {
              //  return .failure(.internalServerError)
                return .failure(error)
            }

        case .failure(let error):
            let statusCode = error.response?.statusCode
            switch statusCode {
            case APIErrorCode.invalidNickname.rawValue:
                //return .failure(.invalidNickname)
                return.failure(error)
                
            case APIErrorCode.unAuthorized.rawValue:
                AuthAPIService.fetchIDToken {
                    print("토큰새로 발급 완료")
                }
               // return .failure(.unAuthorized)
                print("토큰오류: ", error)
                return.failure(error)
                
            case APIErrorCode.notAcceptable.rawValue: //406: 미가입회원
                    // return .failure(.notAcceptable)
                return.failure(error)
                
            default:
          //      return .failure(.internalServerError)
                return.failure(error)
            }
        }
    }

    static func processJSONResponse(_ result: Result<Response, MoyaError>) -> Result<Model?, APIErrorCode> {
        switch result {
            
        case .success(let response):
            do {
                let model = try JSONDecoder().decode(Model.self, from: response.data)
                
                return .success(model)
            } catch {
                  return .failure(.internalServerError)
//                return .failure(error)
            }
        case .failure(let error):

            let statusCode = error.response?.statusCode
            switch statusCode {
            case APIErrorCode.invalidNickname.rawValue:
                return .failure(.invalidNickname)
//                return.failure(error)
                
            case APIErrorCode.unAuthorized.rawValue:
                AuthAPIService.fetchIDToken {
                    print("토큰새로 발급 완료")
                }
                return .failure(.unAuthorized)
                print("토큰오류: ", error)
//                return.failure(error)
                
            case APIErrorCode.notAcceptable.rawValue: //406: 미가입회원
                     return .failure(.notAcceptable)
//                return.failure(error)
                
            default:
                return .failure(.internalServerError)
//                return.failure(error)
            }
        }
    }
}
