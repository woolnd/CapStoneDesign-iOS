//
//  IntroView.swift
//  CapStoneDesign
//
//  Created by Wodnd on 5/22/24.
//

import SwiftUI

struct IntroView: View {
    let text: String
    @State private var splashChar = ""
    @State private var logoOpacity = 0.0
    @State private var logoOffsetY = -10.0
    @State private var buttonOpacity = 0.0
    let timer = Timer.publish(every: 0.15, on: .main, in: .common).autoconnect()
    let logotimer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    
    var body: some View {
        GeometryReader{ geo in
            NavigationStack{
                ZStack{
                    Image("initial_background")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .ignoresSafeArea()
                    
                    VStack{
                        ZStack{
                            Image("logo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 120, height: 48)
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 80, trailing: 130))
                                .opacity(logoOpacity)
                            Text(splashChar)
                                .font(.Kyobo)
                                .bold()
                                .onReceive(timer){_ in
                                    if splashChar.count < text.count{
                                        let index = text.index(text.startIndex, offsetBy: splashChar.count)
                                        splashChar.append(text[index])
                                        withAnimation(.easeInOut(duration: 1.0)) {logoOpacity = 1.0}
                                    }
                            }
                            
                        }
                    }
                    VStack{
                        
                        Spacer()
                        
                        NavigationLink {
                            PreviewView()
                        } label: {
                            Text("처음이신가요?")
                                .font(.custom("777Balsamtint", size: 20))
                                .opacity(0.5)
                        }
                        .padding()
                        NavigationLink {
                            SplashView(text: "MoodMingle")
                        } label: {
                            Text("로그인 하기")
                                .font(.custom("777Balsamtint", size: 20))
                                .opacity(0.5)
                        }
                    }

                }
            }
            .accentColor(.black)
        }
    }
}

#Preview {
    IntroView(text: "MoodMingle")
}
