//
//  DiaryWeatherView.swift
//  CapStoneDesign
//
//  Created by Wodnd on 4/27/24.
//

import SwiftUI

struct DiaryWeatherView: View {
    var weather: EmotionViewModel.weather
    
    var body: some View {
        ZStack{
            Image("\(weather.imageName)")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50)
            Image("diary_check")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50)
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                .opacity(weather.isSelected == true ? 1 : 0)
        }
    }
}

#Preview {
    DiaryWeatherView(weather: EmotionViewModel.weather(imageName: "cloud", isSelected: true))
}
