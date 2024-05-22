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

class AppleAuthManager: NSObject, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
    static let shared = AppleAuthManager()
    
    
    func getAppleTokens(completion: @escaping (Result<AppleTokenResponse, Error>) -> Void) {
        
        let clientSecret = makeJWT()
        UserDefaults.standard.set(clientSecret, forKey: "clientSecret")
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
    
    
    
    func revokeAppleToken(completionHandler: @escaping () -> Void) {
            guard let clientSecret = UserDefaults.standard.string(forKey: "clientSecret"),
                  let token = UserDefaults.standard.string(forKey: "code") else {
                print("clientSecret or token not found in UserDefaults")
                completionHandler()
                return
            }
            
            let url = "https://appleid.apple.com/auth/revoke"
            let parameters: [String: Any] = [
                "client_id": "com.riu.MoodMingle",
                "client_secret": clientSecret,
                "token": token,
                "token_type_hint": "refresh_token"
            ]
            let headers: HTTPHeaders = ["Content-Type": "application/x-www-form-urlencoded"]
            
            AF.request(url, method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers: headers)
                .validate(statusCode: 200..<600)
                .responseData { response in
                    guard let statusCode = response.response?.statusCode else { return }
                    if statusCode == 200 {
                        print("애플 토큰 삭제 성공!")
                        self.clearAppleSession {
                            self.clearUserDefaults()
                            completionHandler()
                        }
                    }
                }
        }
        
        func clearAppleSession(completion: @escaping () -> Void) {
            guard let userIdentifier = UserDefaults.standard.string(forKey: "userIdentifier") else {
                completion()
                return
            }
            
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            appleIDProvider.getCredentialState(forUserID: userIdentifier) { (credentialState, error) in
                switch credentialState {
                case .authorized:
                    self.performAppleSignOut(completion: completion)
                case .revoked, .notFound:
                    print("애플 로그아웃 상태")
                    completion()
                default:
                    completion()
                }
            }
        }
        
        func performAppleSignOut(completion: @escaping () -> Void) {
            let requests = [
                ASAuthorizationAppleIDProvider().createRequest()
            ]
            let authorizationController = ASAuthorizationController(authorizationRequests: requests)
            authorizationController.delegate = self
            authorizationController.presentationContextProvider = self
            authorizationController.performRequests()
            
            // Completion handler called after the authorization controller completes the requests
            DispatchQueue.main.async {
                completion()
            }
        }
        
        func clearUserDefaults() {
            UserDefaults.standard.removeObject(forKey: "clientSecret")
            UserDefaults.standard.removeObject(forKey: "code")
            UserDefaults.standard.removeObject(forKey: "userIdentifier")
            UserDefaults.standard.removeObject(forKey: "AppleIdToken")
            print("UserDefaults cleared")
        }
        
        // ASAuthorizationControllerDelegate methods
        func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
            if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
                UserDefaults.standard.set(appleIDCredential.user, forKey: "userIdentifier")
                if let identityToken = appleIDCredential.identityToken,
                   let idTokenString = String(data: identityToken, encoding: .utf8) {
                    UserDefaults.standard.set(idTokenString, forKey: "AppleIdToken")
                }
                
                // Now perform sign in with the newly obtained credentials
                // You can call getAppleTokens or other methods to complete sign-in flow here
            }
        }
        
        func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
            print("Apple Sign In failed: \(error.localizedDescription)")
        }
        
        // ASAuthorizationControllerPresentationContextProviding method
        func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
            return UIApplication.shared.windows.first { $0.isKeyWindow }!
        }
}
