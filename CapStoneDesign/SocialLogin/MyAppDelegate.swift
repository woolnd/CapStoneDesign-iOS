//
//  MyAppDelegate.swift
//  CapStoneDesign
//
//  Created by Wodnd on 5/4/24.
//

import Foundation
import UIKit
import KakaoSDKCommon
import KakaoSDKAuth

class MyAppDelegate: UIResponder, UIApplicationDelegate{
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        let kakaoAppKey = Bundle.main.infoDictionary?["KAKAO_NATIVE_APP_KEY"] ?? ""
        
        //print("\(kakaoAppKey)")
        // Kakao SDK 초기화
        KakaoSDK.initSDK(appKey: kakaoAppKey as! String)
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if (AuthApi.isKakaoTalkLoginUrl(url)) {
            return AuthController.handleOpenUrl(url: url)
        }
        
        return false
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        let sceneConfiguration = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        
        sceneConfiguration.delegateClass = MySceneDelegate.self
        
        return sceneConfiguration
    }
    
//    let service = Service()
//    
//    func applicationWillTerminate(_ application: UIApplication) {
//        // 앱이 종료될 때 로그아웃 요청
//        logout()
//    }
//    
//    func logout() {
//        service.LogoutRequest { result in
//            switch result {
//            case .success:
//                print("Logout successful")
//            case .failure(let error):
//                print("Logout failed: \(error)")
//            }
//        }
//    }
}

