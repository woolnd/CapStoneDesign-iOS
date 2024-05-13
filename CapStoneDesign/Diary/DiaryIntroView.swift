//
//  DiaryIntroView.swift
//  CapStoneDesign
//
//  Created by Wodnd on 5/14/24.
//

import SwiftUI

struct DiaryIntroView: View {
    @ObservedObject var viewModel = InitialViewModel(contents: InitialViewModel.mock)
    
    var body: some View {
        GeometryReader{ geo in
            ZStack{
                Image("initial_background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    
                    Text("MoodMingle")
                        .font(.custom("KyoboHandwriting2021sjy", size: 25))
                    
                    VStack {
                        Text("\(viewModel.contents[0].title)")
                            .font(.custom("777Balsamtint", size: 35))
                    
                        Image("initial_logo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: geo.size.width * 0.6)
                    
                        ZStack{
                            Image("initial_content")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geo.size.width * 0.8)
                            
                            Text("\(viewModel.contents[0].content)")
                                .font(.custom("777Balsamtint", size: 19))
                                .frame(width: geo.size.width * 0.7)
                        }
                        Spacer()
                    }
                }
                
            }
        }
    }
}

#Preview {
    DiaryIntroView()
}
