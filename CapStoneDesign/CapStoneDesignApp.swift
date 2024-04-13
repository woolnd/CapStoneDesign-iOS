//
//  CapStoneDesignApp.swift
//  CapStoneDesign
//
//  Created by Wodnd on 4/3/24.
//

import SwiftUI

@main
struct CapStoneDesignApp: App {

    var body: some Scene {
        WindowGroup {
            ZStack{
                
                SplashView(text: "MoodMingle").transition(.opacity).zIndex(1)
            }
        }
    }
}
