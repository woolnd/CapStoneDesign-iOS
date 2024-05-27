//
//  PreviewView.swift
//  CapStoneDesign
//
//  Created by Wodnd on 5/22/24.
//

import SwiftUI

struct PreviewView: View {
    
    @State private var currentPage = 0
    @ObservedObject var viewModel = PreviewViewModel(contents: PreviewViewModel.mock)
    let timer = Timer.publish(every: 4, on: .main, in: .common).autoconnect()
    @State private var disableAnimation = false
    
    var body: some View {
        GeometryReader{ geo in
            
            NavigationStack{
                ZStack{
                    Image("initial_background")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .ignoresSafeArea()
                    
                    VStack{
                        
                        HStack{
                            
                            Rectangle()
                                .frame(width: geo.size.width * 0.18, height: geo.size.width * 0.18)
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: geo.size.width * 0.05))
                                .foregroundColor(.clear)
                            
                            Spacer()
                            
                            Text("MoodMingle")
                                .font(.custom("KyoboHandwriting2021sjy", size: geo.size.width * 0.05))
                            
                            Spacer()
                            
                            Rectangle()
                                .frame(width: geo.size.width * 0.18, height: geo.size.width * 0.18)
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: geo.size.width * 0.05))
                                .foregroundColor(.clear)
                            
                        }
                        TabView(selection: $currentPage) {
                            ForEach(viewModel.contents.indices, id: \.self) { index in
                                
                                VStack {
                                    Text("\(viewModel.contents[index].title)")
                                        .font(.custom("777Balsamtint", size: 25))
                                        .multilineTextAlignment(.center)
                                        .frame(maxWidth: .infinity, alignment: .center)
                                    
                                    Image("\(viewModel.contents[index].content)")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: geo.size.width * 0.6)
                                    
                                }
                            }
                        }
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                        .onReceive(timer) { _ in
                            if currentPage == viewModel.contents.count - 1 {
                                // 마지막 페이지일 때, 애니메이션 없이 첫 번째 페이지로 전환
                                disableAnimation = true
                                currentPage = 0
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    disableAnimation = false
                                }
                            } else {
                                withAnimation {
                                    currentPage += 1
                                }
                            }
                        }
                        .animation(disableAnimation ? .none : .default)
                        
                        Spacer()
                        
                        NavigationLink {
                            SplashView(text: "MoodMingle")
                        } label: {
                            Text("로그인 하기")
                                .font(.custom("777Balsamtint", size: 20))
                                .opacity(0.5)
                        }
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: geo.size.width * 0.15, trailing: 0))
                    }
                }
            }
            .accentColor(.black)

        }
        .toolbar(.hidden)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    PreviewView()
}
