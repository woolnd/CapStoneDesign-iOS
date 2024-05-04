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
                
                SplashView(text: "MoodMingle").transition(.opacity).zIndex(1).environmentObject(stateManager)
                    .onOpenURL { url in
                        if (AuthApi.isKakaoTalkLoginUrl(url)) {
                            _ = AuthController.handleOpenUrl(url: url)
                        }
                    }
            }
        }
    }
}
