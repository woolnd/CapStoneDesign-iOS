//
//  InitialView.swift
//  CapStoneDesign
//
//  Created by Wodnd on 4/11/24.
//

import SwiftUI


struct InitialView: View {
    @State private var currentPage = 0
    @ObservedObject var viewModel = InitialViewModle(contents: InitialViewModle.mock)

    var body: some View {
        GeometryReader { geometry in
            NavigationView{
                VStack {
                    Text("MoodMingle")
                        .font(.custom("KyoboHandwriting2021sjy", size: 25))
                        .padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
                    
                    TabView(selection: $currentPage) {
                        ForEach(viewModel.contents.indices, id: \.self) { index in
                            VStack {
                                Text("\(viewModel.contents[index].title)")
                                    .font(.custom("777Balsamtint", size: 35))
                                    .padding(EdgeInsets(top: 40, leading: 0, bottom: 0, trailing: 0))
                            
                                
                                ZStack {
                                    if(currentPage == 3){
                                        Image("initial_last_logo")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(maxWidth: 200, maxHeight: 170)
                                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 500, trailing: 0))

                                        Image("triangle")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(maxWidth: 76, maxHeight: 39)
                                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 180, trailing: 0))
                                        Rectangle()
                                            .foregroundColor(.white)
                                            .frame(maxWidth: 318, maxHeight: 300)
                                            .cornerRadius(15)
                                            .padding(EdgeInsets(top: 140, leading: 0, bottom: 0, trailing: 0))
                                        
                                        Text("\(viewModel.contents[index].content)")
                                            .font(.custom("777Balsamtint", size: 20))
                                        
                                        NavigationLink {
                                            TabBarView()
                                        } label: {
                                            Image("initial_btn")
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(maxWidth: 318, maxHeight: 50)
                                                .padding(EdgeInsets(top: 520, leading: 15, bottom: 0, trailing: 15))
                                        }

                                    }
                                    else{
                                        Image("initial_logo")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(maxWidth: 300, maxHeight: 270)
                                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 550, trailing: 0))
                                            
                                    
                                        Rectangle()
                                            .foregroundColor(.white)
                                            .frame(maxWidth: 318, maxHeight: 438)
                                            .cornerRadius(15)
                                        
                                        Text("\(viewModel.contents[index].content)")
                                            .font(.custom("777Balsamtint", size: 20))
                                    }
                                }
                                .frame(width: geometry.size.width * 1)
                            }
                            .tag(index)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    .overlay {
                        VStack {
                            Spacer()
                            
                            HStack(spacing: 5) {
                                ForEach(0..<viewModel.contents.count) { index in
                                    Capsule()
                                        .fill(index == currentPage ? Color.red : Color.black)
                                        .frame(width: index == currentPage ? 21 : 8, height: 8)
                                        .opacity(0.6)
                                }
                            }
                            .padding(.bottom, 120)
                        }
                    }
                }
                .background(
                    Image("initial_background")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .ignoresSafeArea()
                )
            }
            .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    InitialView()
}
