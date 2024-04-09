//
//  CapStoneDesignApp.swift
//  CapStoneDesign
//
//  Created by Wodnd on 4/3/24.
//

import SwiftUI

@main
struct CapStoneDesignApp: App {

    @State var isLoading: Bool = true
    
    var body: some Scene {
        WindowGroup {
            
            ZStack{

                if isLoading{
                    SplashView.transition(.opacity).zIndex(1)
                }
                TabBarView().zIndex(0)
                
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                    withAnimation {
                        isLoading = false
                    }
                })
            }
        }
    }
}

extension CapStoneDesignApp {
    
    var SplashView: some View {
        
        ZStack {
            
            LinearGradient(colors: [.blue, .orange], startPoint: .topLeading, endPoint: .bottomTrailing)
              .overlay(Text("AppName"))
            .edgesIgnoringSafeArea(.all)
        }
    }
    
}
