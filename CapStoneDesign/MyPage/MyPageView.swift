//
//  MyPageView.swift
//  CapStoneDesign
//
//  Created by Wodnd on 4/10/24.
//

import SwiftUI
import UserNotifications

struct MyPageView: View {
    
    @State private var isLowPowerMode = false
    
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
                        
                        }, label: {
                            Image("mypage_btn")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        })
                    }
                    
                    HStack{
                        Spacer()
                        
                        Toggle("", isOn: $isLowPowerMode)
                            .tint(.orange)
                        
                    }
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 10))
                    
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
            }
        }
        .toolbar(.hidden)
        .navigationBarBackButtonHidden(true)
        
    }
}

#Preview {
    MyPageView()
}

