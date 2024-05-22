//
//  Service.swift
//  CapStoneDesign
//
//  Created by Wodnd on 5/6/24.
//

import Foundation
import Alamofire
import UIKit

class Service{
    
    func LetterRequest(letter: DiaryDto, completion: @escaping (Result<Int, Error>) -> Void) {
        let URL = "https://moodmingle.store/api/v1/diary/letter"
        let token = UserDefaults.standard.string(forKey: "AccessToken") ?? ""
        let header: HTTPHeaders = [.authorization(bearerToken: token)]
        
        let dto : [String : Any] = ["title": letter.dto.title,
                                    "date": letter.dto.date,
                                    "content": letter.dto.content,
                                    "emotion": letter.dto.emotion,
                                    "weather": letter.dto.weather]
        
        let image = base64ToImage(letter.image)
        
        guard let imageData = image?.jpegData(compressionQuality: 1) else {
            print("Failed to convert image to JPEG data")
            return
        }
        
        AF.upload(multipartFormData: { multipartFormData in
            
            multipartFormData.append(try! JSONSerialization.data(withJSONObject: dto), withName: "dto", mimeType: "application/json")
            // 이미지 데이터 추가
            multipartFormData.append(imageData, withName: "image", fileName: "image.jpg", mimeType: "image/jpg")
            print("\(letter.image)")
        }, to: URL, method: .post, headers: header).responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard response.value != nil else { return }
                completion(.success(statusCode))
            case .failure(let error):
                if let data = response.data,
                   let apiError = try? JSONDecoder().decode(APIError.self, from: data),
                   apiError.code == "AUTH-001" {
                    self.RefreshRequest { refreshResult in
                        switch refreshResult {
                        case .success:
                            let letterDto = CapStoneDesign.DiaryDto(dto: Dto(title: letter.dto.title, date: letter.dto.date, content: letter.dto.content, emotion: letter.dto.emotion, weather: letter.dto.weather), image: letter.image)
                            self.AdviceRequest(advice: letterDto, completion: completion)
                        case .failure(let refreshError):
                            completion(.failure(refreshError))
                        }
                    }
                } else {
                    completion(.failure(error))
                }
            }
        }
    }
    
    func SympathyRequest(sympathy: DiaryDto, completion: @escaping (Result<Int, Error>) -> Void) {
        let URL = "https://moodmingle.store/api/v1/diary/sympathy"
        
        let token = UserDefaults.standard.string(forKey: "AccessToken") ?? ""
        let header: HTTPHeaders = [.authorization(bearerToken: token)]
//        let header: HTTPHeaders = ["Content-Type" : "multipart/form-data"]
        
        let dto : [String : Any] = ["title": sympathy.dto.title,
                                    "date": sympathy.dto.date,
                                    "content": sympathy.dto.content,
                                    "emotion": sympathy.dto.emotion,
                                    "weather": sympathy.dto.weather]
        
        let image = base64ToImage(sympathy.image)
        
        guard let imageData = image?.jpegData(compressionQuality: 1) else {
            print("Failed to convert image to JPEG data")
            return
        }
        
        AF.upload(multipartFormData: { multipartFormData in
            
            multipartFormData.append(try! JSONSerialization.data(withJSONObject: dto), withName: "dto", mimeType: "application/json")
            // 이미지 데이터 추가
            multipartFormData.append(imageData, withName: "image", fileName: "image.jpg", mimeType: "image/jpg")
            print("\(sympathy.image)")
        }, to: URL, method: .post, headers: header).responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard response.value != nil else { return }
                completion(.success(statusCode))
            case .failure(let error):
                if let data = response.data,
                   let apiError = try? JSONDecoder().decode(APIError.self, from: data),
                   apiError.code == "AUTH-001" {
                    self.RefreshRequest { refreshResult in
                        switch refreshResult {
                        case .success:
                            let sympathyDto = CapStoneDesign.DiaryDto(dto: Dto(title: sympathy.dto.title, date: sympathy.dto.date, content: sympathy.dto.content, emotion: sympathy.dto.emotion, weather: sympathy.dto.weather), image: sympathy.image)
                            self.AdviceRequest(advice: sympathyDto, completion: completion)
                        case .failure(let refreshError):
                            completion(.failure(refreshError))
                        }
                    }
                } else {
                    completion(.failure(error))
                }
            }
        }
    }
    
    func AdviceRequest(advice: DiaryDto, completion: @escaping (Result<Int, Error>) -> Void) {
        let URL = "https://moodmingle.store/api/v1/diary/advice"
        
        let token = UserDefaults.standard.string(forKey: "AccessToken") ?? ""
        let header: HTTPHeaders = [.authorization(bearerToken: token)]
//        let header: HTTPHeaders = ["Content-Type" : "multipart/form-data"]
        
        let dto : [String : Any] = ["title": advice.dto.title,
                                    "date": advice.dto.date,
                                    "content": advice.dto.content,
                                    "emotion": advice.dto.emotion,
                                    "weather": advice.dto.weather]
        
        let image = base64ToImage(advice.image)
        
        guard let imageData = image?.jpegData(compressionQuality: 1) else {
            print("Failed to convert image to JPEG data")
            return
        }
        
        AF.upload(multipartFormData: { multipartFormData in
            
            multipartFormData.append(try! JSONSerialization.data(withJSONObject: dto), withName: "dto", mimeType: "application/json")
            // 이미지 데이터 추가
            multipartFormData.append(imageData, withName: "image", fileName: "image.jpg", mimeType: "image/jpg")
            print("\(advice.image)")
        }, to: URL, method: .post, headers: header).responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard response.value != nil else { return }
                completion(.success(statusCode))
            case .failure(let error):
                if let data = response.data,
                   let apiError = try? JSONDecoder().decode(APIError.self, from: data),
                   apiError.code == "AUTH-001" {
                    self.RefreshRequest { refreshResult in
                        switch refreshResult {
                        case .success:
                            let adviceDto = CapStoneDesign.DiaryDto(dto: Dto(title: advice.dto.title, date: advice.dto.date, content: advice.dto.content, emotion: advice.dto.emotion, weather: advice.dto.weather), image: advice.image)
                            self.AdviceRequest(advice: adviceDto, completion: completion)
                        case .failure(let refreshError):
                            completion(.failure(refreshError))
                        }
                    }
                } else {
                    completion(.failure(error))
                }

            }
        }
    }
    
    func base64ToImage(_ base64String: String) -> UIImage? {
        guard let imageData = Data(base64Encoded: base64String) else {
            return nil
        }
        guard let image = UIImage(data: imageData) else {
            return nil
        }
        return image
    }
    
    
    func DiaryRequest(dtos: DiaryRequest, completion: @escaping (Result<[DiaryResponse], Error>) -> Void) {
        
        let URL = "https://moodmingle.store/api/v1/diary"
        
        let dto : [String : Any] = ["date": dtos.dto.date]
        
        let token = UserDefaults.standard.string(forKey: "AccessToken") ?? ""
        let header: HTTPHeaders = [.authorization(bearerToken: token)]
        
        AF.request(URL,
                   method: .get,
                   parameters: dto,
                   headers: header)
        .validate(statusCode: 200..<300)
        .responseDecodable(of: [DiaryResponse].self) { response in
            switch response.result {
            case .success(let diaryResponses):
                completion(.success(diaryResponses))
            case .failure(let error):
                if let data = response.data,
                   let apiError = try? JSONDecoder().decode(APIError.self, from: data),
                   apiError.code == "AUTH-001" {
                    self.RefreshRequest { refreshResult in
                        switch refreshResult {
                        case .success:
                            let diaryRequest = CapStoneDesign.DiaryRequest(dto: MonthDto(date: dtos.dto.date))
                            self.DiaryRequest(dtos: diaryRequest, completion: completion)
                        case .failure(let refreshError):
                            completion(.failure(refreshError))
                        }
                    }
                } else {
                    completion(.failure(error))
                }
            }
        }
    }
    
    func DiaryDetailRequest(dtos: DiaryDetailRequest, completion: @escaping (Result<DiaryDetailReponse, Error>) -> Void) {
        
        let URL = "https://moodmingle.store/api/v1/diary/detail"
        
        let dto : [String : Any] = ["diaryId": dtos.dto.diaryId]
        
        let token = UserDefaults.standard.string(forKey: "AccessToken") ?? ""
        let header: HTTPHeaders = [.authorization(bearerToken: token)]
        
        AF.request(URL,
                   method: .get,
                   parameters: dto,
                   headers: header)
        .validate(statusCode: 200..<300)
        .responseDecodable(of: DiaryDetailReponse.self) { response in
            switch response.result {
            case .success(let diaryResponses):
                completion(.success(diaryResponses))
            case .failure(let error):
                if let data = response.data,
                   let apiError = try? JSONDecoder().decode(APIError.self, from: data),
                   apiError.code == "AUTH-001" {
                    self.RefreshRequest { refreshResult in
                        switch refreshResult {
                        case .success:
                            let diaryDetailRequest = CapStoneDesign.DiaryDetailRequest(dto: Diary(diaryId: dtos.dto.diaryId))
                            self.DiaryDetailRequest(dtos: diaryDetailRequest, completion: completion)
                        case .failure(let refreshError):
                            completion(.failure(refreshError))
                        }
                    }
                } else {
                    completion(.failure(error))
                }
            }
        }
    }
    
    func EmotionRequest(dtos: DiaryRequest, completion: @escaping (Result<GraphResponse, Error>) -> Void) {
        
        let URL = "https://moodmingle.store/api/v1/diary/monthly-emotion"
        
        let dto : [String : Any] = ["date": dtos.dto.date]
        
        let token = UserDefaults.standard.string(forKey: "AccessToken") ?? ""
        let header: HTTPHeaders = [.authorization(bearerToken: token)]
        
        AF.request(URL,
                   method: .get,
                   parameters: dto,
                   headers: header)
        .validate(statusCode: 200..<300)
        .responseDecodable(of: GraphResponse.self) { response in
            switch response.result {
            case .success(let emotionResponses):
                completion(.success(emotionResponses))
            case .failure(let error):
                if let data = response.data,
                   let apiError = try? JSONDecoder().decode(APIError.self, from: data),
                   apiError.code == "AUTH-001" {
                    self.RefreshRequest { refreshResult in
                        switch refreshResult {
                        case .success:
                            // Retry EmotionRequest after refreshing the token
                            let emotionRequest = CapStoneDesign.DiaryRequest(dto: MonthDto(date: dtos.dto.date))
                            self.EmotionRequest(dtos: emotionRequest, completion: completion)
                        case .failure(let refreshError):
                            completion(.failure(refreshError))
                        }
                    }
                } else {
                    completion(.failure(error))
                }
            }
        }
    }
    
    func KakaoJoinRequest(completion: @escaping (Result<JoinResponse, Error>) -> Void) {
        
        let URL = "https://moodmingle.store/api/v1/member/join/kakao"
        
        let token = UserDefaults.standard.string(forKey: "KakaoIdToken")!
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        
        AF.request(URL,
                   method: .post,
                   headers: headers)
        .validate(statusCode: 200..<300)
        .responseDecodable(of: JoinResponse.self) { response in
            switch response.result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func AppleJoinRequest(completion: @escaping (Result<JoinResponse, Error>) -> Void) {
        
        let user = UserDefaults.standard.string(forKey: "AppleUser")!
        print("api호출에서 사용되는 값\(user)")
        let url = "https://moodmingle.store/api/v1/member/login/apple"
        
        let dto : [String : Any] = ["user": user]
    
        
        let token = UserDefaults.standard.string(forKey: "AppleIdToken")!
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        
        AF.request(url,
                   method: .post,
                   parameters: dto,
                   encoding: URLEncoding.queryString,
                   headers: headers)
        .validate(statusCode: 200..<300)
        .responseDecodable(of: JoinResponse.self) { response in
            switch response.result {
            case .success(let result):
                UserDefaults.standard.set(result.accessToken, forKey: "AccessToken")
                print("\(result.accessToken)")
                UserDefaults.standard.set(result.refreshToken, forKey: "RefreshToken")
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func KakaoLoginRequest(completion: @escaping (Result<LoginResponse, Error>) -> Void) {
        
        let URL = "https://moodmingle.store/api/v1/member/login/kakao"
        
        let token = UserDefaults.standard.string(forKey: "KakaoIdToken")!
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        
        AF.request(URL,
                   method: .post,
                   headers: headers)
        .validate(statusCode: 200..<300)
        .responseDecodable(of: LoginResponse.self) { response in
            switch response.result {
            case .success(let result):
                UserDefaults.standard.set(result.accessToken, forKey: "AccessToken")
                UserDefaults.standard.set(result.refreshToken, forKey: "RefreshToken")
                completion(.success(result))
            case .failure(let error):
                if let data = response.data,
                   let apiError = try? JSONDecoder().decode(APIError.self, from: data),
                   apiError.code == "M-001" {
                    self.KakaoJoinRequest { result in
                        switch result {
                        case .success:
                            // Retry InfoRequest after refreshing the token
                            self.KakaoLoginRequest(completion: completion)
                        case .failure(let Error):
                            completion(.failure(Error))
                        }
                    }
                } else {
                    completion(.failure(error))
                }
            }
        }
    }
    
    func LogoutRequest(completion: @escaping (Result<String, Error>) -> Void) {
        
        let URL = "https://moodmingle.store/api/v1/member/logout"
        
        let token = UserDefaults.standard.string(forKey: "AccessToken") ?? ""
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        
        AF.request(URL,
                   method: .post,
                   headers: headers)
        .validate(statusCode: 200..<300)
        .responseDecodable(of: String.self) { response in
            switch response.result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                if let data = response.data,
                   let apiError = try? JSONDecoder().decode(APIError.self, from: data),
                   apiError.code == "AUTH-001" {
                    self.RefreshRequest { refreshResult in
                        switch refreshResult {
                        case .success:
                            // Retry InfoRequest after refreshing the token
                            self.LogoutRequest(completion: completion)
                        case .failure(let refreshError):
                            completion(.failure(refreshError))
                        }
                    }
                } else {
                    completion(.failure(error))
                }
            }
        }
    }
    
    //탈퇴
    func LeaveRequest(completion: @escaping (Result<String, Error>) -> Void) {
        
        let URL = "https://moodmingle.store/api/v1/member"
        
        let token = UserDefaults.standard.string(forKey: "AccessToken") ?? ""
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        
        AF.request(URL,
                   method: .delete,
                   headers: headers)
        .validate(statusCode: 200..<300)
        .responseDecodable(of: String.self) { response in
            switch response.result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                if let data = response.data,
                   let apiError = try? JSONDecoder().decode(APIError.self, from: data),
                   apiError.code == "AUTH-001" {
                    self.RefreshRequest { refreshResult in
                        switch refreshResult {
                        case .success:
                            // Retry InfoRequest after refreshing the token
                            self.LeaveRequest(completion: completion)
                        case .failure(let refreshError):
                            completion(.failure(refreshError))
                        }
                    }
                } else {
                    completion(.failure(error))
                }
            }
        }
    }
    
    func InfoRequest(completion: @escaping (Result<InfoResponse, Error>) -> Void) {
        
        let URL = "https://moodmingle.store/api/v1/member"
        
        let token = UserDefaults.standard.string(forKey: "AccessToken") ?? ""
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        
        AF.request(URL,
                   method: .get,
                   headers: headers)
        .validate(statusCode: 200..<300)
        .responseDecodable(of: InfoResponse.self) { response in
            switch response.result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                if let data = response.data,
                   let apiError = try? JSONDecoder().decode(APIError.self, from: data),
                   apiError.code == "AUTH-001" {
                    self.RefreshRequest { refreshResult in
                        switch refreshResult {
                        case .success:
                            // Retry InfoRequest after refreshing the token
                            self.InfoRequest(completion: completion)
                        case .failure(let refreshError):
                            completion(.failure(refreshError))
                        }
                    }
                } else {
                    completion(.failure(error))
                }
            }
        }
    }
    
    func RefreshRequest(completion: @escaping (Result<RefreshResponse, Error>) -> Void) {
        
        let URL = "https://moodmingle.store/api/v1/member/reissue"
        let header: HTTPHeaders = ["Content-Type" : "application/json"]
        let token = UserDefaults.standard.string(forKey: "RefreshToken") ?? ""
        
        let refreshToken : [String : String] = ["refreshToken": token]
        
        AF.request(URL,
                   method: .post,
                   parameters: refreshToken,
                   encoder: JSONParameterEncoder.default,
                   headers: header)
        .validate(statusCode: 200..<300)
        .responseDecodable(of: RefreshResponse.self) { response in
            switch response.result {
            case .success(let result):
                UserDefaults.standard.set(result.accessToken, forKey: "AccessToken")
                UserDefaults.standard.set(result.refreshToken, forKey: "RefreshToken")
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

// APIError 모델 추가
struct APIError: Decodable {
    let status: Int
    let error: String
    let code: String
    let message: String
}
