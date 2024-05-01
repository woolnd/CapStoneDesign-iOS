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
    let manager = NotificationManager.instance
    
    var body: some View {
        NavigationStack{
            ZStack{
                Image("initial_background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                
                VStack{
                    HStack{
                        
                        Spacer()
                        
                        Text("MoodMingle")
                            .font(.custom("KyoboHandwriting2021sjy", size: 25))
                            .padding(EdgeInsets(top: 25, leading: 0, bottom: 0, trailing: 0))
                        
                        Spacer()
                    }
                    
                    Spacer()
                    
                    Image("mypage_main")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                    
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
                            .onChange(of: stateManager.isPasswordSetting) { newValue in
                                if newValue {
                                    stateManager.isPasswordSettingView.toggle()
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
                //                HStack{
                //                    Spacer()
                //
                //                    Button(action: {
                //                        manager.scheduleNotification(trigger: .time)
                //                    }, label: {
                //                        Image("mypage_btn")
                //                            .resizable()
                //                            .aspectRatio(contentMode: .fit)
                //                            .frame(width: 100)
                //                    })
                //                }
            }
        }
        .toolbar(.hidden)
        .navigationBarBackButtonHidden(true)
        
    }
}

#Preview {
    MyPageView().environmentObject(StateManager())
}

