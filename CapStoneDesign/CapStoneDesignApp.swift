//
//  CapStoneDesignApp.swift
//  CapStoneDesign
//
//  Created by Wodnd on 4/3/24.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth

@main
struct CapStoneDesignApp: App {
    
    @UIApplicationDelegateAdaptor var appDelegate: MyAppDelegate
    @StateObject var stateManager = StateManager()
    var body: some Scene {
        WindowGroup {
            ZStack{
                
                let apple = UserDefaults.standard.string(forKey: "AppleIdToken")
                let kakao = UserDefaults.standard.string(forKey: "KakaoIdToken")
                
                if( apple != "" || kakao != ""){
                    SplashView(text: "MoodMingle").transition(.opacity).zIndex(1).environmentObject(stateManager)
                        .onOpenURL { url in
                            if (AuthApi.isKakaoTalkLoginUrl(url)) {
                                _ = AuthController.handleOpenUrl(url: url)
                            }
                        }
                }
                else{
                    IntroView(text: "MoodMingle").transition(.opacity).zIndex(1).environmentObject(stateManager)
                        .onOpenURL { url in
                            if (AuthApi.isKakaoTalkLoginUrl(url)) {
                                _ = AuthController.handleOpenUrl(url: url)
                            }
                        }
                }
            }
        }
    }
}
