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
    @State var appleTokenCheck: Bool = false
    
    
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
    
    let service = Service()
    
    var body: some View {
        
        NavigationStack{
            ZStack{
                
                Image("initial_background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                
                if(kakaoTokenCheck || appleTokenCheck){
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
                        SignInWithAppleButton(
                            onRequest: { request in
                                request.requestedScopes = []
                            },
                            onCompletion: { result in
                                switch result {
                                case .success(let authResults):
                                    print("Apple Login Successful")
                                    switch authResults.credential{
                                    case let appleIDCredential as ASAuthorizationAppleIDCredential:
                                        
                                        if  let authorizationCode = appleIDCredential.authorizationCode,
                                            let identityToken = appleIDCredential.identityToken,
                                            let authCodeString = String(data: authorizationCode, encoding: .utf8),
                                            let identifyTokenString = String(data: identityToken, encoding: .utf8) {
                                            UserDefaults.standard.set(identifyTokenString, forKey: "AppleIdToken")
                                            UserDefaults.standard.set(authCodeString, forKey: "code")
                                            print("authorizationCode: \(authorizationCode)")
                                            print("identityToken: \(identityToken)")
                                            print("authCodeString: \(authCodeString)")
                                            print("identifyTokenString: \(identifyTokenString)")
                                        }
                                        
                                        service.AppleJoinRequest { result in
                                            switch result {
                                            case .success(_):
                                                print("가입 성공")
                                                service.AppleLoginRequest { result in
                                                    switch result {
                                                    case .success(_):
                                                        print("로그인 성공")
                                                    case .failure(let error):
                                                        print("Error: \(error)")
                                                    }
                                                }
                                            case .failure(let error):
                                                print("Error: \(error)")
                                            }
                                        }
                                    default:
                                        break
                                    }
                                case .failure(let error):
                                    print(error.localizedDescription)
                                    print("error")
                                }
                            }
                        )
                        .frame(width : UIScreen.main.bounds.width * 0.9, height:50)
                        .cornerRadius(5)
                        .opacity(buttonOpacity)
                        Button {
                            kakaoAuthVM.handleKakaoLogin { success in
                                if success {
                                    isInitial = true
                                    service.KakaoJoinRequest { result in
                                        switch result {
                                        case .success(_):
                                            print("회원가입 성공")
                                            service.KakaoLoginRequest { result in
                                                switch result {
                                                case .success(_):
                                                    print("로그인 성공")
                                                case .failure(let error):
                                                    print("Error: \(error)")
                                                }
                                            }
                                        case .failure(let error):
                                            print("Error: \(error)")
                                        }
                                    }
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
        .toolbar(.hidden)
        .navigationBarBackButtonHidden(true)
        .fullScreenCover(isPresented: $isInitial, content: {
            InitialView()
        })
    }
    
    func performTokenCheck() {
        if UserDefaults.standard.string(forKey: "AppleIdToken") != nil {
            // IdentityToken이 UserDefaults에 저장되어 있음
            appleTokenCheck = true
            
            // 토큰 재발급 요청
            AppleAuthManager.shared.getAppleTokens { result in
                print("\(result)")
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    changedView()
                }
            }
            
        } else {
            // IdentityToken이 UserDefaults에 저장되어 있지 않음
            appleTokenCheck = false
        }
        
        kakaoAuthVM.handleTokenCheck { success in
            if success {
                // 토큰 체크 성공 시 수행할 동작
                kakaoTokenCheck = true
                
                kakaoAuthVM.refreshToken { success in
                    if success {
                        print("NEW토큰 발급 성공")
                        service.KakaoLoginRequest { result in
                            switch result {
                            case .success(_):
                                print("로그인 성공")
                            case .failure(let error):
                                print("Error: \(error)")
                            }
                        }
                    } else {
                        print("실패")
                    }
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    changedView()
                }
            } else {
                // 토큰 체크 실패 시 수행할 동작
                kakaoTokenCheck = false
                
            }
        }
    }
    
    
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


