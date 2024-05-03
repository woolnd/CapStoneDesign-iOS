//
//  EmotionGraphIntroView.swift
//  CapStoneDesign
//
//  Created by Wodnd on 5/2/24.
//

import SwiftUI

struct EmotionGraphIntroView: View {
    var body: some View {
        ZStack{
            Image("initial_background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
            
            Text("감정 추이란?")
        }
    }
}

#Preview {
    EmotionGraphIntroView()
}
