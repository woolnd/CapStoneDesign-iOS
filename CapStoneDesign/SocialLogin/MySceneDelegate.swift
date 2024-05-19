//
//  MySceneDelegate.swift
//  CapStoneDesign
//
//  Created by Wodnd on 5/4/24.
//

import Foundation
import KakaoSDKAuth
import UIKit

class MySceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            if (AuthApi.isKakaoTalkLoginUrl(url)) {
                _ = AuthController.handleOpenUrl(url: url)
            }
        }
    }
    
    var window: UIWindow?
    let service = Service()
    
//    func sceneDidEnterBackground(_ scene: UIScene) {
//        // 앱이 백그라운드로 진입할 때 로그아웃 요청
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

