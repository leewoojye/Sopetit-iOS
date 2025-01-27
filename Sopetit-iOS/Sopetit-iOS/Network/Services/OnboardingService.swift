//
//
//  OnboardingService.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 2023/12/29.
//

import Foundation

import Alamofire

final class OnBoardingService: BaseService {
    
    static let shared = OnBoardingService()
    
    private override init() {}
}

extension OnBoardingService {
    func getOnboardingThemeAPI(completion: @escaping (NetworkResult<Any>) -> Void) {
        let url = URLConstant.themeURL
        let header: HTTPHeaders = NetworkConstant.noTokenHeader
        let dataRequest = AF.request(url,
                                     method: .get,
                                     encoding: JSONEncoding.default,
                                     headers: header)
        
        dataRequest.responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.data else { return }
                let networkResult = self.judgeStatus(by: statusCode,
                                                     data,
                                                     ThemeSelectEntity.self)
                completion(networkResult)
            case .failure:
                completion(.networkFail)
            }
        }
    }
    
    func getOnboardingDollAPI(
        dollType: String,
        completion: @escaping (NetworkResult<Any>) -> Void) {
            let url = URLConstant.dollImageURL + dollType
            let header: HTTPHeaders = NetworkConstant.noTokenHeader
            let dataRequest = AF.request(url,
                                         method: .get,
                                         encoding: JSONEncoding.default,
                                         headers: header)
            
            dataRequest.responseData { response in
                switch response.result {
                case .success:
                    guard let statusCode = response.response?.statusCode else { return }
                    guard let data = response.data else { return }
                    let networkResult = self.judgeStatus(by: statusCode,
                                                         data,
                                                         DollImageEntity.self)
                    completion(networkResult)
                case .failure:
                    completion(.networkFail)
                }
            }
        }
    
    func getOnboardingRoutineAPI(
        routineID: Int,
        completion: @escaping (NetworkResult<Any>) -> Void) {
            let url = URLConstant.routineURL + String(routineID)
            let header: HTTPHeaders = NetworkConstant.hasTokenHeader
            let dataRequest = AF.request(url,
                                         method: .get,
                                         encoding: JSONEncoding.default,
                                         headers: header)
            
            dataRequest.responseData { response in
                switch response.result {
                case .success:
                    guard let statusCode = response.response?.statusCode else { return }
                    guard let data = response.data else { return }
                    let networkResult = self.judgeStatus(by: statusCode,
                                                         data,
                                                         RoutineChoiceEntity.self)
                    completion(networkResult)
                case .failure:
                    completion(.networkFail)
                }
            }
        }
    
    func postOnboardingMemeberAPI(
        dollType: String,
        dollName: String,
        routineArray: [Int],
        completion: @escaping (NetworkResult<Any>) -> Void) {
            let url = URLConstant.memberURL
            let header: HTTPHeaders = NetworkConstant.hasTokenHeader
            let body: Parameters = [
                "dollType": dollType,
                "name": dollName,
                "routines": routineArray
            ]
            let dataRequest = AF.request(url,
                                         method: .post,
                                         parameters: body,
                                         encoding: JSONEncoding.default,
                                         headers: header)
            
            dataRequest.responseData { response in
                switch response.result {
                case .success:
                    guard let statusCode = response.response?.statusCode else { return }
                    print(statusCode)
                    guard let data = response.data else { return }
                    let networkResult = self.judgeStatus(by: statusCode,
                                                         data,
                                                         MemberEntity.self)
                    completion(networkResult)
                case .failure:
                    completion(.networkFail)
                }
            }
        }
}
