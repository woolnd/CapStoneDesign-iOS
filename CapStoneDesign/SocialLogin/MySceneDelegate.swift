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
    
}

