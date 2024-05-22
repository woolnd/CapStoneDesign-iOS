//
//  AppleAuthManager.swift
//  CapStoneDesign
//
//  Created by Wodnd on 5/22/24.
//

import Foundation
import AuthenticationServices
import Alamofire
import SwiftJWT

class AppleAuthManager {
    
    static let shared = AppleAuthManager()
    
    
    func getAppleTokens(completion: @escaping (Result<AppleTokenResponse, Error>) -> Void) {
            
            let clientSecret = makeJWT()
            let code = UserDefaults.standard.string(forKey: "code")!
        
            let url = "https://appleid.apple.com/auth/token?client_id=com.riu.MoodMingle&client_secret=\(clientSecret)&code=\(code)&grant_type=authorization_code"
            let header: HTTPHeaders = ["Content-Type": "application/x-www-form-urlencoded"]

            AF.request(url, method: .post, headers: header)
                .validate(statusCode: 200..<300)
                .responseDecodable(of: AppleTokenResponse.self) { response in
                    switch response.result {
                    case .success(let result):
                        if result.id_token != nil{
                            UserDefaults.standard.set(result.id_token, forKey: "AppleIdToken")
                        }
                        completion(.success(result))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    func makeJWT() -> String{
            let myHeader = Header(kid: "AH6KYR87NK") //sign in with
            struct MyClaims: Claims {
                let iss: String
                let iat: Int
                let exp: Int
                let aud: String
                let sub: String
            }

            let nowDate = Date()
            var dateComponent = DateComponents()
            dateComponent.month = 6
            let sixDate = Calendar.current.date(byAdding: dateComponent, to: nowDate) ?? Date()
            let iat = Int(Date().timeIntervalSince1970)
            let exp = iat + 3600
            let myClaims = MyClaims(iss: "23SCTLK482",
                                    iat: iat,
                                    exp: exp,
                                    aud: "https://appleid.apple.com",
                                    sub: "com.riu.MoodMingle")

            var myJWT = JWT(header: myHeader, claims: myClaims)

            //JWT 발급을 요청값의 암호화 과정에서 다운받아두었던 Key File이 필요하다.(.p8 파일)
            guard let url = Bundle.main.url(forResource: "AuthKey_AH6KYR87NK", withExtension: "p8") else{
                return ""
            }
            
            let privateKey: Data = try! Data(contentsOf: url, options: .alwaysMapped)

            let jwtSigner = JWTSigner.es256(privateKey: privateKey)
            let signedJWT = try! myJWT.sign(using: jwtSigner)
            return signedJWT
        }
}
