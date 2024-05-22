//
//  AccountManagementView.swift
//  CapStoneDesign
//
//  Created by Wodnd on 4/30/24.
//

import SwiftUI
import Kingfisher

struct AccountManagementView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let service = Service()
    @State var name: String = ""
    @State var email: String = ""
    @State var imageUrl: String = ""
    
    @StateObject var kakaoAuthVM: KakaoAuthViewModel = KakaoAuthViewModel()
    @State var isLogout: Bool = false
    @State var isLeave: Bool = false
    
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
                            
                            Button(action: {
                                self.presentationMode.wrappedValue.dismiss()
                            }, label: {
                                
                                Image(systemName: "chevron.left")
                                    .resizable()// 화살표 Image
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geo.size.width * 0.04)
                            })
                            .padding(EdgeInsets(top: 0, leading: geo.size.width * 0.05, bottom: 0, trailing: 0))
                            
                            Spacer()
                            
                            Text("MoodMingle")
                                .font(.custom("KyoboHandwriting2021sjy", size: geo.size.width * 0.05))
                            
                            Spacer()
                            
                            Rectangle()
                                .frame(width: geo.size.width * 0.13, height: geo.size.width * 0.18)
                                .foregroundColor(.clear)
                        }
                        
                        Spacer()
                        
                        ZStack{
                            Image("account_back")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geo.size.width * 0.99)
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: geo.size.width * 0.05))
                            
                            VStack{
                                
                                Spacer()
                                
                                if imageUrl == ""{
                                    Image("initial_last_logo")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: geo.size.width * 0.3)
                                        .cornerRadius(geo.size.width * 0.25)
                                }else{
                                    let url = URL(string: imageUrl)
                                    KFImage(url)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: geo.size.width * 0.3)
                                        .cornerRadius(geo.size.width * 0.25)
                                }
                                
                                
                                
                                VStack{
                                    Text("이름: \(name)")
                                        .font(.custom("777Balsamtint", size: geo.size.width * 0.07))
                                        .padding()
                                    Text("이메일: \(email)")
                                        .font(.custom("777Balsamtint", size: geo.size.width * 0.05))
                                }
                                .padding(EdgeInsets(top: geo.size.width * 0.2, leading: 0, bottom: geo.size.width * 0.2, trailing: 0))
                                
                                
                                
                                
                                Button {
                                    service.LogoutRequest { result in
                                        switch result{
                                        case.success(let success):
                                            print("\(success)")
                                        case .failure(let error):
                                            print("\(error)")
                                        }
                                    }
                                    kakaoAuthVM.handleKakaoLogout()
                                    UserDefaults.standard.removeObject(forKey: "AppleIdToken")
                                    UserDefaults.standard.removeObject(forKey: "KakaoIdToken")
                                    UserDefaults.standard.removeObject(forKey: "AccessToken")
                                    UserDefaults.standard.removeObject(forKey: "RefreshToken")
                                    UserDefaults.standard.removeObject(forKey: "clientSecret")
                                    UserDefaults.standard.removeObject(forKey: "code")
                                    
                                    isLogout = true
                                } label: {
                                    Text("로그아웃")
                                        .font(.custom("777Balsamtint", size: geo.size.width * 0.04))
                                }
                                .fullScreenCover(isPresented: $isLogout, content: {
                                    SplashView(text: "MoodMingle")
                                })
                                
                                
                                Button {
                                    service.LeaveRequest { result in
                                        switch result{
                                        case.success(let success):
                                            print("\(success)")
                                        case .failure(let error):
                                            print("\(error)")
                                        }
                                    }
                                    kakaoAuthVM.handleKakaoLogout()
                                    UserDefaults.standard.removeObject(forKey: "AppleIdToken")
                                    UserDefaults.standard.removeObject(forKey: "KakaoIdToken")
                                    UserDefaults.standard.removeObject(forKey: "AccessToken")
                                    UserDefaults.standard.removeObject(forKey: "RefreshToken")
                                    UserDefaults.standard.removeObject(forKey: "clientSecret")
                                    UserDefaults.standard.removeObject(forKey: "code")
                                    isLeave = true
                                } label: {
                                    Text("회원탈퇴")
                                        .font(.custom("777Balsamtint", size: geo.size.width * 0.04))
                                }
                                .fullScreenCover(isPresented: $isLeave, content: {
                                    IntroView(text: "MoodMingle")
                                })
                                
                                Spacer()
                                
                            }
                            Spacer()
                        }
                    }
                    
                    
                }
            }
            .accentColor(Color.black)
        }
        .onAppear(){
            service.InfoRequest { result in
                switch result {
                case .success(let success):
                    name = success.name ?? ""
                    email = success.email ?? ""
                    imageUrl = success.imageUrl ?? ""
                case .failure(let error):
                    service.RefreshRequest { result in
                        switch result {
                        case .success(let success):
                            print("\(success)")
                        case .failure(let error):
                            print("Error: \(error)")
                        }
                    }
                    print("Error: \(error)")
                }
            }
        }
        .toolbar(.hidden)
        .navigationBarBackButtonHidden()
    }
    
}

#Preview {
    AccountManagementView()
}
