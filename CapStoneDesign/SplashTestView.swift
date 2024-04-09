//
//  SplashView.swift
//  CapStoneDesign
//
//  Created by Wodnd on 4/7/24.
//

import SwiftUI

struct SplashTestView: View {
    var body: some View {
        ZStack {
            
            LinearGradient(colors: [.blue, .orange], startPoint: .topLeading, endPoint: .bottomTrailing)
              .overlay(Text("AppName"))
            .edgesIgnoringSafeArea(.all)
        }
    }
}

#Preview {
    SplashTestView()
}
