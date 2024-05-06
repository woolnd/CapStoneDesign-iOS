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

class KakaoAuthViewModel: ObservableObject{
    
    func handleKakaoLogin(){
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
            if let error = error {
                print(error)
            }
            else {
                print("loginWithKakaoAccount() success.")
                
                //do something
                let token = oauthToken
                if let accessToken = token?.accessToken {
                    let accessTokenString = String(accessToken)
                    UserDefaults.standard.set(accessTokenString, forKey: "KakaoToken")
                    print("\(token)")
                }
            }
        }
    }
    
    func handleKakaoLogout(){
        UserApi.shared.logout {(error) in
            if let error = error {
                print(error)
            }
            else {
                print("logout() success.")
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
                    print("\(access_token)")
                    // 작업이 성공적으로 완료되었으므로 true를 반환
                    completion(true)
                } else {
                    // access_token이 nil이면 실패로 간주하여 false를 반환
                    completion(false)
                }
            }
        }
    }
}
