//
//  EmotionDetailView.swift
//  CapStoneDesign
//
//  Created by Wodnd on 4/12/24.
//

import SwiftUI

struct EmotionDetailView: View {
    
    @State var emotion: EmotionViewModel.emotion
    var body: some View {
        ZStack{
            Rectangle()
                .frame(width: 147, height: 118)
                .foregroundColor(.white)
                .cornerRadius(15)
            VStack{
                Text("\(emotion.name)")
                    .font(.custom("777Balsamtint", size: 20))
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: -20, trailing: 0))
                Image("\(emotion.imageName)")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 90, height: 90)
            }
        }
    }
}

#Preview {
    EmotionDetailView(emotion: EmotionViewModel.emotion(name: "기쁨", imageName: "pleasure"))
}
