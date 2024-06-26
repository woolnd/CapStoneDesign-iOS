//
//  MyPageView.swift
//  CapStoneDesign
//
//  Created by Wodnd on 4/10/24.
//

import SwiftUI
import UserNotifications

struct MyPageView: View {
    
    @EnvironmentObject var stateManager: StateManager
    @State private var isPasswordSettingViewActive = false
    fileprivate var APP_SCREEN_LOCK_PASSWORD = "AppScreenLockPassWord"
    
    @State private var showingAlert = false
    @State private var showingTermsOfUse = false
    
    var body: some View {
        GeometryReader { geo in
            NavigationStack {
                ZStack {
                    Image("initial_background")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .ignoresSafeArea()
                    
                    VStack {
                        HStack {
                            Rectangle()
                                .frame(width: geo.size.width * 0.13, height: geo.size.width * 0.18)
                                .foregroundColor(.clear)
                            
                            Spacer()
                            
                            Text("MoodMingle")
                                .font(.custom("KyoboHandwriting2021sjy", size: geo.size.width * 0.05))
                            
                            Spacer()
                            
                            Rectangle()
                                .frame(width: geo.size.width * 0.13, height: geo.size.width * 0.18)
                                .foregroundColor(.clear)
                        }
                        
                        Spacer()
                        
                        Image("mypage_main")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(EdgeInsets(top: 0, leading: geo.size.width * 0.03, bottom: geo.size.width * 0.05, trailing: geo.size.width * 0.03))
                        
                        Spacer()
                        
                    }
                    
                    VStack(spacing: 35) {
                        
                        Rectangle()
                            .opacity(0)
                        
                        Spacer()
                        
                        Rectangle()
                            .opacity(0)
                        
                        Spacer()
                        
                        HStack {
                            Spacer()
                            
                            Button(action: {
                                self.showingAlert.toggle()
                                
                            }, label: {
                                Image("mypage_btn")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            })
                            .alert(isPresented: $showingAlert) {
                                Alert(title: Text("알림 기능"), message: Text("추후 업데이트 예정"),
                                      dismissButton: .default(Text("닫기")))
                            }
                        }
                        
                        HStack {
                            Spacer()
                            
                            Toggle("", isOn: $stateManager.isPasswordSetting)
                                .tint(.orange)
                                .onChange(of: stateManager.isPasswordSetting) {
                                    handlePasswordSettingChange(stateManager.isPasswordSetting)
                                }
                                .sheet(isPresented: $stateManager.isPasswordSettingView) {
                                    PasswordSettingView()
                                }
                        }
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                        
                        HStack {
                            Spacer()
                            
                            NavigationLink {
                                AnnouncementView()
                            } label: {
                                Image("mypage_btn")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            }
                        }
                        
                        HStack {
                            Spacer()
                            
                            NavigationLink {
                                ServiceCenterView()
                            } label: {
                                Image("mypage_btn")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            }
                        }
                        
                        HStack {
                            Spacer()
                            
                            NavigationLink {
                                AccountManagementView()
                            } label: {
                                Image("mypage_btn")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            }
                        }
                        
                        HStack {
                            Spacer()
                            
                            Button(action: {
                                self.showingTermsOfUse.toggle()
                            }) {
                                Image("mypage_btn")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            }
                            .sheet(isPresented: $showingTermsOfUse) {
                                WebView(url: URL(string: "https://github.com/woolnd/CapStoneDesign-iOS/blob/main/%EC%9D%B4%EC%9A%A9%EC%95%BD%EA%B4%80.md")!)
                            }
                        }
                        
                        Spacer()
                        
                        Rectangle()
                            .opacity(0)
                        
                        Rectangle()
                            .opacity(0)
                    }
                    .offset(x: -40)
                }
            }
            .toolbar(.hidden)
            .navigationBarBackButtonHidden(true)
            .onAppear {
                stateManager.checkIsUserSetPassword()
            }
        }
    }
    
    private func handlePasswordSettingChange(_ isPasswordSetting: Bool) {
        if isPasswordSetting {
            let appScreenLockPassword = getUD(key: APP_SCREEN_LOCK_PASSWORD)
            if appScreenLockPassword as? [Int] == [] {
                stateManager.isPasswordSettingView = true
            } else {
                // User Set Password
                stateManager.isPasswordSettingView = false
            }
        } else {
            removeUD(key: APP_SCREEN_LOCK_PASSWORD)
        }
    }
}

#Preview {
    MyPageView().environmentObject(StateManager())
}
