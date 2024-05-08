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
    
    var imageData: Data? = UIImage(named: "initial_last_logo")?.pngData()
    
    func diaryRequest(completion: @escaping (Result<Int, Error>) -> Void) {
        DispatchQueue.global().async {
            let URL = "http://52.78.41.105:8080/api/v1/diary/letter"
            let header: HTTPHeaders = [ "Content-Type" : "multipart/form-data" ]
            
            let diary = Dto(memberId: 0,
                            title: "hello",
                            date: "2024/05/06",
                            content: "테스트입니다",
                            emotion: "SADNESS",
                            weather: "CLOUDY")
            
            AF.upload(multipartFormData: { multipartFormData in
                if let jsonData = try? JSONEncoder().encode(diary) {
                    multipartFormData.append(jsonData, withName: "dto")
                }
                if let image = self.imageData {
                    multipartFormData.append(image, withName: "image", fileName: "\(image).png", mimeType: "image/png")
                }
            }, to: URL, usingThreshold: UInt64.init(), method: .post, headers: header).responseData { response in
                switch response.result {
                case .success:
                    guard let statusCode = response.response?.statusCode else { return }
                    guard let data = response.value else { return }
                    completion(.success(statusCode))
                case .failure(let err):
                    print(err)
                    completion(.failure(err))
                }
            }
        }
    }
}
