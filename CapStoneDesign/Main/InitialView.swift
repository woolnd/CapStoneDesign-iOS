//
//  InitialView.swift
//  CapStoneDesign
//
//  Created by Wodnd on 4/11/24.
//

import SwiftUI

struct InitialView: View {
    @State private var currentPage = 0
    @ObservedObject var viewModel = InitialViewModel(contents: InitialViewModel.mock)

    var body: some View {
        GeometryReader{ geo in
            NavigationView{
                ZStack{
                    Image("initial_background")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .ignoresSafeArea()
                    
                    VStack {
                        Spacer()
                        
                        Text("MoodMingle")
                            .font(.custom("KyoboHandwriting2021sjy", size: 25))
                        
                        TabView(selection: $currentPage) {
                            ForEach(viewModel.contents.indices, id: \.self) { index in
                                
                                VStack {
                                    Text("\(viewModel.contents[index].title)")
                                        .font(.custom("777Balsamtint", size: 35))
                                    
                                    if(currentPage == 3){
                                        VStack{
                                            Image("initial_last_logo")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: geo.size.width * 0.55)

                                            ZStack{
                                                Image("initial_last_content")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: geo.size.width * 0.8)
                                                
                                                Text("\(viewModel.contents[index].content)")
                                                    .font(.custom("777Balsamtint", size: 19))
                                                    .frame(width: geo.size.width * 0.7)
                                                
                                                HStack(spacing: 5) {
                                                    ForEach(0..<viewModel.contents.count) { index in
                                                        Capsule()
                                                            .fill(index == currentPage ? Color.red : Color.black)
                                                            .frame(width: index == currentPage ? 21 : 8, height: 8)
                                                            .opacity(0.6)
                                                    }
                                                }
                                                .offset(CGSize(width: 0.0, height: geo.size.height * 0.18))
                                                
                                            }
                                        }
                                        NavigationLink {
                                            TabBarView()
                                        } label: {
                                            Image("initial_btn")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: geo.size.width * 0.8)
                                        }

                                    }
                                    else{
                                        Image("initial_logo")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: geo.size.width * 0.6)
                                    
                                        ZStack{
                                            Image("initial_content")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: geo.size.width * 0.8)
                                            
                                            Text("\(viewModel.contents[index].content)")
                                                .font(.custom("777Balsamtint", size: 19))
                                                .frame(width: geo.size.width * 0.7)
                                            
                                            HStack(spacing: 5) {
                                                ForEach(0..<viewModel.contents.count) { index in
                                                    Capsule()
                                                        .fill(index == currentPage ? Color.red : Color.black)
                                                        .frame(width: index == currentPage ? 21 : 8, height: 8)
                                                        .opacity(0.6)
                                                }
                                            }
                                            .offset(CGSize(width: 0.0, height: geo.size.height * 0.25))
                                        }
                                        Spacer()
                                    }
                                    
                                    Spacer()
                                    
                                }
                                .tag(index)
                            }
                        }
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    }
                }
            }
            .navigationBarBackButtonHidden()
        }
        
    }
}

#Preview {
    InitialView()
}
