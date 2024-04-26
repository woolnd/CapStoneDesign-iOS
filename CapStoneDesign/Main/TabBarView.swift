//
//  ContentView.swift
//  CapStoneDesign
//
//  Created by Wodnd on 4/3/24.
//

import SwiftUI

struct TabBarView: View {
    @State private var selection = 1
    
    var body: some View {
        
        NavigationStack{
            TabView(selection: $selection){
                
                EmotionalStatusView()
                    .tabItem {
                        Image(selection == 0 ? "emotion_tab" : "emotion_blank_tab")
                        Text("감정추이")
                            .font(.custom("777Balsamtint", size: 18))
                            .foregroundColor(selection == 0 ? .black : .gray)
                    }.tag(0)
                CalendarView()
                    .tabItem {
                        Image(selection == 1 ? "calendar_tab" : "calendar_blank_tab")
                        Text("일기")
                            .font(.custom("777Balsamtint", size: 18))
                            .foregroundColor(selection == 1 ? .black : .gray)
                    }.tag(1)
                MyPageView()
                    .tabItem {
                        Image(selection == 2 ? "mypage_tab" : "mypage_blank_tab")
                        Text("내정보")
                            .font(.custom("777Balsamtint", size: 18))
                            .foregroundColor(selection == 2 ? .black : .gray)
                    }.tag(2)
            }
            .accentColor(Color.black)
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    TabBarView()
}
