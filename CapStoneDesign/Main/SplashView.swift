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
    @State var appleTokenCheck: Bool = false
    @State var kakaoTokenCheck: Bool = false

    @State var isActive = false
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
                
                if(appleTokenCheck || kakaoTokenCheck){
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
                        
                        
                        AppleSigninButton()
                            .opacity(buttonOpacity)
                        //                        Button {
                        //
                        //                        } label: {
                        //                            Image("apple_login")
                        //                                .resizable()
                        //                                .aspectRatio(contentMode: .fit)
                        //                                .frame(maxWidth: .infinity)
                        //                                .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
                        //                                .opacity(buttonOpacity)
                        //                        }
                        
                        Button {
                            kakaoAuthVM.handleKakaoLogin()
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
            .onAppear(){
                
                if UserDefaults.standard.string(forKey: "AppleToken") != nil {
                    // IdentityToken이 UserDefaults에 저장되어 있음
                    appleTokenCheck = true
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        changedView()
                    }
                } else {
                    // IdentityToken이 UserDefaults에 저장되어 있지 않음
                    appleTokenCheck = false
                }
                
                
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
            .accentColor(.black)
        }
    }
    func changedView(){
        self.isActive.toggle()
    }
}

extension Font{
    
    static let Kyobo: Font = custom("KyoboHandwriting2021sjy", size: 58)
}

struct AppleSigninButton : View{
    var body: some View{
        SignInWithAppleButton(
            onRequest: { request in
                request.requestedScopes = [.fullName, .email]
            },
            onCompletion: { result in
                switch result {
                case .success(let authResults):
                    print("Apple Login Successful")
                    switch authResults.credential{
                    case let appleIDCredential as ASAuthorizationAppleIDCredential:
                        // 계정 정보 가져오기
                        let UserIdentifier = appleIDCredential.user
                        let fullName = appleIDCredential.fullName
                        let name =  (fullName?.familyName ?? "") + (fullName?.givenName ?? "")
                        let email = appleIDCredential.email
                        let IdentityToken = String(data: appleIDCredential.identityToken!, encoding: .utf8)
                        UserDefaults.standard.set(IdentityToken, forKey: "AppleToken")
                        let AuthorizationCode = String(data: appleIDCredential.authorizationCode!, encoding: .utf8)
                        print("\(IdentityToken!)")
                    default:
                        break
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    print("error")
                }
            }
        )
        .frame(width : UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.06)
    }
}

#Preview {
    SplashView(text: "MoodMingle")
}


