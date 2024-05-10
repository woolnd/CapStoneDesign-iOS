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
    
    func LetterRequest(letter: LetterDto, completion: @escaping (Result<Int, Error>) -> Void) {
        let URL = "http://52.78.41.105:8080/api/v1/diary/letter"
        let header: HTTPHeaders = ["Content-Type" : "multipart/form-data"]
        
        let dto : [String : Any] = ["memberId": letter.dto.memberId,
                                    "title": letter.dto.title,
                                    "date": letter.dto.date,
                                    "content": letter.dto.content,
                                    "emotion": letter.dto.emotion,
                                    "weather": letter.dto.weather]
        
        var image = UIImage(named: letter.image)
        
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
                print("\(response.result)")
                completion(.success(statusCode))
            case .failure(let err):
                print(err)
                completion(.failure(err))
            }
        }
    }
    
//    func diaryRequest(completion: @escaping (Result<Int, Error>) -> Void) {
//        let URL = "http://52.78.41.105:8080/api/v1/diary/letter"
//        let header: HTTPHeaders = ["Content-Type" : "multipart/form-data"]
//        
//        let dto : [String : Any] = ["memberId": 1,
//                                    "title": "hello",
//                                    "date": "2024/05/12",
//                                    "content": "테스트입니다",
//                                    "emotion": "SADNESS",
//                                    "weather": "CLOUDY"]
//        
//        var image = UIImage(named: "SUNNY")!
//        
//        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
//            print("Failed to convert image to JPEG data")
//            return
//        }
//        AF.upload(multipartFormData: { multipartFormData in
//
//            multipartFormData.append(try! JSONSerialization.data(withJSONObject: dto), withName: "dto", mimeType: "application/json")
//            // 이미지 데이터 추가
//            multipartFormData.append(imageData, withName: "image", fileName: "image.jpg", mimeType: "image/jpg")
//            print("\(imageData)")
//        }, to: URL, method: .post, headers: header).responseData { response in
//            switch response.result {
//            case .success:
//                guard let statusCode = response.response?.statusCode else { return }
//                guard let data = response.value else { return }
//                print("\(response.result)")
//                completion(.success(statusCode))
//            case .failure(let err):
//                print(err)
//                completion(.failure(err))
//            }
//        }
//    }
}
