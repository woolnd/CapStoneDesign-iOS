//
//  test.swift
//  CapStoneDesign
//
//  Created by Wodnd on 4/11/24.
//

import SwiftUI

struct SplashView: View {
    
    let text: String
    @State private var splashChar = ""
    @State private var logoOpacity = 0.0
    @State private var logoOffsetY = +50.0
    @State private var buttonOpacity = 0.0
    let timer = Timer.publish(every: 0.15, on: .main, in: .common).autoconnect()
    let logotimer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    let aftertimer = Timer.publish(every: 2.5, on: .main, in: .common).autoconnect()
    
    
    var body: some View {
        VStack {
            Spacer()
            
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
            .offset(y: logoOffsetY)
            .onReceive(logotimer){_ in
                withAnimation{
                    logoOffsetY = -30
                }
            }
            
            Spacer()
            
            Button(action: {
                
            }, label: {
                Image("kakao_login")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
                    .opacity(buttonOpacity)
            })
            
            Button(action: {
                
            }, label: {
                Image("naver_login")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .padding(EdgeInsets(top: 0, leading: 15, bottom: 50, trailing: 15))
                    .opacity(buttonOpacity)
            })
            
        }
        .onReceive(aftertimer){_ in
            withAnimation{
                logoOffsetY = -30
                buttonOpacity = 1
                
            }
        }
        .background(
            Image("initial_background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
        )
    }
}

extension Font{
    
    static let Kyobo: Font = custom("KyoboHandwriting2021sjy", size: 58)
}
#Preview {
    SplashView(text: "MoodMingle")
}
