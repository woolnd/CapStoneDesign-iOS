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
                print(error)
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
                print(error)
                completion(.failure(error))
            }
        }
    }
    
    func EmotionRequest(dto: DiaryRequest, completion: @escaping (Result<Int, Error>) -> Void) {
        
        let URL = "http://52.78.41.105:8080/api/v1/diary/monthly-emotion"
        
        let dto : [String : Any] = ["memberId": dto.dto.memberId,
                                    "date": dto.dto.date]
        
        AF.request(URL,
                   method: .get,
                   parameters: dto)
        .validate(statusCode: 200..<300)
        .responseDecodable(of: GraphResponse.self) { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard response.value != nil else { return }
                print("\(response.result)")
                completion(.success(statusCode))
            case .failure(let err):
                print(err)
                completion(.failure(err))
            }
        }
    }
}
