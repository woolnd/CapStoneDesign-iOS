//
//  KakaoAuthViewModel.swift
//  CapStoneDesign
//
//  Created by Wodnd on 5/4/24.
//

import Foundation
import Combine
import KakaoSDKUser
import KakaoSDKAuth

class KakaoAuthViewModel: ObservableObject {
    
    @Published var isLoggedIn: Bool = false
    
    // 로그인 처리 함수
    func handleKakaoLogin(completion: @escaping (Bool) -> Void) {
        UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
            if let error = error {
                print(error)
                completion(false)
            } else {
                print("loginWithKakaoAccount() success.")
                
                // 로그인 성공 시 처리
                if let token = oauthToken {
                    self.saveToken(oauthToken: token)
                    self.isLoggedIn = true
                    completion(true)
                } else {
                    completion(false)
                }
            }
        }
    }
    
    // 로그아웃 처리 함수
    func handleKakaoLogout() {
        UserApi.shared.logout { (error) in
            if let error = error {
                print(error)
            } else {
                print("logout() success.")
                self.clearToken()
                self.isLoggedIn = false
            }
        }
    }
    
    func handleTokenCheck(completion: @escaping (Bool) -> Void) {
        // 사용자 액세스 토큰 정보 조회
        UserApi.shared.accessTokenInfo { (accessTokenInfo, error) in
            if let error = error {
                print(error)
                completion(false) // 에러가 발생한 경우 false를 반환
            } else {
                print("accessTokenInfo() success.")
                
                // 처리할 작업이 있으면 이곳에서 처리
                if let access_token = accessTokenInfo {
                    completion(true)
                } else {
                    // access_token이 nil이면 실패로 간주하여 false를 반환
                    completion(false)
                }
            }
        }
    }
    
    func refreshToken(completion: @escaping (Bool) -> Void) {
        AuthApi.shared.refreshToken { (idToken, error) in
            if let error = error {
                print(error)
                completion(false) // 에러가 발생한 경우 false를 반환
            } else {
                if let id_token = idToken {
                    print("\(id_token)")
                    self.saveToken(oauthToken: id_token)
                    completion(true)
                } else {
                    // access_token이 nil이면 실패로 간주하여 false를 반환
                    completion(false)
                }
            }
        }
    }
    
    // 토큰 저장 함수
    private func saveToken(oauthToken: OAuthToken) {
        print("\(oauthToken.idToken)")
        UserDefaults.standard.set(oauthToken.idToken, forKey: "KakaoIdToken")
    }
    
    // 토큰 삭제 함수
    private func clearToken() {
        UserDefaults.standard.removeObject(forKey: "KakaoIdToken")
    }
}
