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
        
        HStack{
            Spacer()
                .frame(width: 10)
            Button(action: {
                
            }, label: {
                Image(systemName: "questionmark.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30)
                    .foregroundColor(.black)
            })
            Spacer()
            Text("App Name")
                .font(.system(size: 20, weight: .bold, design: .serif))
                .foregroundColor(.black)
            Spacer()
                .frame(width: 145)
        }
        
        TabView(selection: $selection){
            Text("Emotion Graph")
                .tabItem {
                    Image(systemName: "heart.circle")
                    Text("Emotion")
                }.tag(0)
            CalendarView()
                .tabItem {
                    Image(systemName: "house.circle")
                    Text("Main")
                }.tag(1)
            Text("MyPage")
                .tabItem {
                    Image(systemName: "person.circle")
                    Text("My")
                }.tag(2)
        }
        .font(.headline)
        .onAppear {
            selection = 1 // 앱 실행시 가운데 탭이 보이도록 선택값을 1로 초기화
        }
    }
    
}

#Preview {
    TabBarView()
}