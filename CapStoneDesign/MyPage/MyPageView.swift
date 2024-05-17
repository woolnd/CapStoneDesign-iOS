//
//  MyPageView.swift
//  CapStoneDesign
//
//  Created by Wodnd on 4/10/24.
//

import SwiftUI
import UserNotifications

struct MyPageView: View {
    
    @EnvironmentObject var stateManager : StateManager
    @State private var isPasswordSettingViewActive = false
    fileprivate var APP_SCREEN_LOCK_PASSWORD = "AppScreenLockPassWord"
    
    let manager = NotificationManager.instance
    
    
    
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
                    
                    VStack(spacing: 35){
                        
                        Rectangle()
                            .opacity(0)
                        
                        Spacer()
                        
                        Rectangle()
                            .opacity(0)
                        
                        
                        Spacer()
                        
                        HStack{
                            Spacer()
                            
                            Button(action: {
                                manager.requestAuthorization()
                            }, label: {
                                Image("mypage_btn")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            })
                        }
                        
                        HStack{
                            Spacer()

                            Toggle("", isOn: $stateManager.isPasswordSetting)
                                .tint(.orange)
                                .onChange(of: stateManager.isPasswordSetting) { 
                                    if stateManager.isPasswordSetting {
                                        
                                        let AppScreenLockPassword = getUD(key: APP_SCREEN_LOCK_PASSWORD)
                                        if AppScreenLockPassword as! [Int] == [] {
                                            stateManager.isPasswordSettingView = true
                                        } else {
                                            // User Set Password
                                            stateManager.isPasswordSettingView = false
                                        }
                                        
                                    } else {
                                        removeUD(key: APP_SCREEN_LOCK_PASSWORD)
                                    }
                                }
                                .sheet(isPresented: $stateManager.isPasswordSettingView, content: {
                                    PasswordSettingView()
                                })
                            
                        }
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                        
                        HStack{
                            Spacer()
                            
                            NavigationLink {
                                AnnouncementView()
                            } label: {
                                Image("mypage_btn")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            }
                            
                        }
                        
                        HStack{
                            Spacer()
                            
                            NavigationLink {
                                ServiceCenterView()
                            } label: {
                                Image("mypage_btn")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            }
                        }
                        
                        HStack{
                            Spacer()
                            
                            NavigationLink {
                                AccountManagementView()
                            } label: {
                                Image("mypage_btn")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            }
                        }
                        
                        HStack{
                            Spacer()
                            
                            NavigationLink {
                                TermsOfUseView()
                            } label: {
                                Image("mypage_btn")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            }
                        }
                        
                        Spacer()
                        
                        Rectangle()
                            .opacity(0)
                        
                        
                        Rectangle()
                            .opacity(0)
                    }
                    .offset(x: -40)
                    //푸시알림 테스트 코드
                                    HStack{
                                        Spacer()
                    
                                        Button(action: {
                                            manager.scheduleNotification(trigger: .time)
                                        }, label: {
                                            Image("mypage_btn")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 100)
                                        })
                                    }
                }
            }
            .toolbar(.hidden)
            .navigationBarBackButtonHidden(true)
            .onAppear(){
                stateManager.checkIsUserSetPassword()
            }
        }
        
    }
}

#Preview {
    MyPageView().environmentObject(StateManager())
}

