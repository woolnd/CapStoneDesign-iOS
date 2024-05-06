//
//  Service.swift
//  CapStoneDesign
//
//  Created by Wodnd on 5/6/24.
//

import Foundation
import Alamofire

class Service{
    
    
    func diaryRequest(dto: Dto, image: Data, completion: @escaping (Result<DiaryResponse, Error>) -> Void) {
            DispatchQueue.global().async {
                let url = "http://52.78.41.105:8080/api/v1/diary/letter"
                AF.request(url,
                           method: .post,
                           parameters: DiaryRequest(dto: dto, image: image),
                           encoder: JSONParameterEncoder.default,
                           headers: HTTPHeaders(["Content-Type": "application/json"]))
                    .validate(statusCode: 200..<300)
                    .responseDecodable(of: DiaryResponse.self) { response in
                        switch response.result {
                        case .success(let data):
                            completion(.success(data))
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
            }
        }
}
