//
//  test.swift
//  CapStoneDesign
//
//  Created by Wodnd on 4/11/24.
//

import SwiftUI
import AuthenticationServices

struct SplashView: View {
    
    @StateObject var kakaoAuthVM: KakaoAuthViewModel = KakaoAuthViewModel()
    @State var kakaoTokenCheck: Bool = false
    
    @State var isActive = false
    @State var isInitial = false
    
    let text: String
    @State private var splashChar = ""
    @State private var logoOpacity = 0.0
    @State private var logoOffsetY = -10.0
    @State private var buttonOpacity = 0.0
    let timer = Timer.publish(every: 0.15, on: .main, in: .common).autoconnect()
    let logotimer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    let aftertimer = Timer.publish(every: 2.5, on: .main, in: .common).autoconnect()
    
    var body: some View {
        
        NavigationStack{
            ZStack{
                Image("initial_background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                
                if(kakaoTokenCheck){
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
                    .fullScreenCover(isPresented: $isActive, content: {
                        TabBarView(selection: 1)
                    })
                    
                }else{
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
                        .offset(y: logoOffsetY)
                        .onReceive(logotimer){_ in
                            withAnimation{
                                logoOffsetY = -50
                            }
                        }
                    }
                    
                    VStack {
                        
                        Spacer()
                        
                        Button {
                            kakaoAuthVM.handleKakaoLogin { success in
                                if success {
                                    isInitial = true
                                } else {
                                   isInitial = false
                                }
                            }
                        } label: {
                            Image("kakao_login")
                                .resizable()
                                .frame(width : UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.06)
                                .padding(EdgeInsets(top: 0, leading: 15, bottom: 50, trailing: 15))
                                .opacity(buttonOpacity)
                        }
//                        NavigationLink {
//                            
//                        } label: {
//                            Image("kakao_login")
//                                .resizable()
//                                .frame(width : UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.06)
//                                .padding(EdgeInsets(top: 0, leading: 15, bottom: 50, trailing: 15))
//                                .opacity(buttonOpacity)
//                        }
                        
                    }
                    .onReceive(aftertimer){_ in
                        withAnimation{
                            logoOffsetY = -50
                            buttonOpacity = 1
                            
                        }
                    }
                }
                
            }
            .accentColor(.black)
            .onAppear(){
                performTokenCheck()
            }
        }
        .fullScreenCover(isPresented: $isInitial, content: {
            InitialView()
        })
    }
    
    // Function to perform token check
    func performTokenCheck() {
        //            if UserDefaults.standard.string(forKey: "AppleToken") != nil {
        //                // IdentityToken이 UserDefaults에 저장되어 있음
        //                appleTokenCheck = true
        //
        //                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        //                    changedView()
        //                }
        //            } else {
        //                // IdentityToken이 UserDefaults에 저장되어 있지 않음
        //                appleTokenCheck = false
        //            }
        //
        //            if UserDefaults.standard.string(forKey: "KakaoToken") != nil {
        //                // IdentityToken이 UserDefaults에 저장되어 있음
        //                kakaoTokenCheck = true
        //
        //                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        //                    changedView()
        //                }
        //            } else {
        //                // IdentityToken이 UserDefaults에 저장되어 있지 않음
        //                kakaoTokenCheck = false
        //            }
        kakaoAuthVM.handleTokenCheck { success in
            if success {
                // 토큰 체크 성공 시 수행할 동작
                kakaoTokenCheck = true
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    changedView()
                }
            } else {
                // 토큰 체크 실패 시 수행할 동작
                kakaoTokenCheck = false
            }
        }
    }
    
//    func loginSuccess() -> some View{
//        kakaoAuthVM.handleKakaoLogin { success in
//            if success {
//               return InitialView()
//            } else {
//               return SplashView(text: "MoodMingle")
//            }
//        }
//    }
    
    func changedView(){
        self.isActive.toggle()
    }
}

extension Font{
    
    static let Kyobo: Font = custom("KyoboHandwriting2021sjy", size: 58)
}


#Preview {
    SplashView(text: "MoodMingle")
}


