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
        let URL = "http://52.78.41.105:8080/api/v1/diary/letter"
        let header: HTTPHeaders = ["Content-Type" : "multipart/form-data"]
        
        let dto : [String : Any] = ["memberId": letter.dto.memberId,
                                    "title": letter.dto.title,
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
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }
    
    func SympathyRequest(sympathy: DiaryDto, completion: @escaping (Result<Int, Error>) -> Void) {
        let URL = "http://52.78.41.105:8080/api/v1/diary/sympathy"
        let header: HTTPHeaders = ["Content-Type" : "multipart/form-data"]
        
        let dto : [String : Any] = ["memberId": sympathy.dto.memberId,
                                    "title": sympathy.dto.title,
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
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }
    
    func AdviceRequest(advice: DiaryDto, completion: @escaping (Result<Int, Error>) -> Void) {
        let URL = "http://52.78.41.105:8080/api/v1/diary/advice"
        let header: HTTPHeaders = ["Content-Type" : "multipart/form-data"]
        
        let dto : [String : Any] = ["memberId": advice.dto.memberId,
                                    "title": advice.dto.title,
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
            case .failure(let err):
                completion(.failure(err))
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
    
    
    func DiaryRequest(dto: DiaryRequest, completion: @escaping (Result<[DiaryResponse], Error>) -> Void) {
        
        let URL = "http://52.78.41.105:8080/api/v1/diary"
        
        let dto : [String : Any] = ["memberId": dto.dto.memberId,
                                    "date": dto.dto.date]
        
        AF.request(URL,
                   method: .get,
                   parameters: dto)
        .validate(statusCode: 200..<300)
        .responseDecodable(of: [DiaryResponse].self) { response in
            switch response.result {
            case .success(let diaryResponses):
                completion(.success(diaryResponses))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func DiaryDetailRequest(dto: DiaryDetailRequest, completion: @escaping (Result<DiaryDetailReponse, Error>) -> Void) {
        
        let URL = "http://52.78.41.105:8080/api/v1/diary/detail"
        
        let dto : [String : Any] = ["memberId": dto.dto.memberId,
                                    "diaryId": dto.dto.diaryId]
        
        AF.request(URL,
                   method: .get,
                   parameters: dto)
        .validate(statusCode: 200..<300)
        .responseDecodable(of: DiaryDetailReponse.self) { response in
            switch response.result {
            case .success(let diaryResponses):
                completion(.success(diaryResponses))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func EmotionRequest(dto: DiaryRequest, completion: @escaping (Result<GraphResponse, Error>) -> Void) {
        
        let URL = "http://52.78.41.105:8080/api/v1/diary/monthly-emotion"
        
        let dto : [String : Any] = ["memberId": dto.dto.memberId,
                                    "date": dto.dto.date]
        
        AF.request(URL,
                   method: .get,
                   parameters: dto)
        .validate(statusCode: 200..<300)
        .responseDecodable(of: GraphResponse.self) { response in
            switch response.result {
            case .success(let emotionResponses):
                completion(.success(emotionResponses))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func JoinRequest(completion: @escaping (Result<JoinResponse, Error>) -> Void) {
        
        let URL = "http://52.78.41.105:8080/api/v1/member/join"
        
        var token = UserDefaults.standard.string(forKey: "KakaoIdToken")!
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
    
    func LoginRequest(completion: @escaping (Result<LoginResponse, Error>) -> Void) {
        
        let URL = "http://52.78.41.105:8080/api/v1/member/login"
        
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
                print("토큰이야: \(result.accessToken)")
                UserDefaults.standard.set(result.refreshToken, forKey: "refreshToken")
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func LogoutRequest(completion: @escaping (Result<String, Error>) -> Void) {
        
        let URL = "http://52.78.41.105:8080/api/v1/member/logout"
        
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
                completion(.failure(error))
            }
        }
    }
    
    func InfoRequest(completion: @escaping (Result<InfoResponse, Error>) -> Void) {
        
        let URL = "http://52.78.41.105:8080/api/v1/member"
        
        let token = UserDefaults.standard.string(forKey: "AccessToken") ?? ""
        let token1 = "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjQsImlhdCI6MTcxNjA1NzA0OSwiZXhwIjoxNzE3MjU3MDQ5fQ.EItkOGWUzEJvGBnXGk0OK6xq5pB9Soje-ikNQNJOJGE"
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
                completion(.failure(error))
            }
        }
    }
}
