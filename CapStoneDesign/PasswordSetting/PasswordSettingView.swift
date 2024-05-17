//
//  PasswordSettingView.swift
//  CapStoneDesign
//
//  Created by Wodnd on 5/2/24.
//

import SwiftUI
import Combine

struct PasswordSettingView: View {
    @EnvironmentObject var stateManager : StateManager
    @StateObject var passwordSettingViewModel = PasswordSettingViewModel()
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    var body: some View {
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
                
                HStack{
                    
                    Spacer()
                    
                    Text("새 비밀번호를 입력해주세요")
                        .font(.custom("777Balsamtint", size: 35))
                        .padding(EdgeInsets(top: 25, leading: 0, bottom: 0, trailing: 0))
                    
                    Spacer()
                }
                
                
                
                HStack(spacing: 10){
                    Group {
                        Image(passwordSettingViewModel.passwordFieldArray.count >= 1 ? "FLUTTER" : "PEACE")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        Image(passwordSettingViewModel.passwordFieldArray.count >= 2 ? "FLUTTER" : "PEACE")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        Image(passwordSettingViewModel.passwordFieldArray.count >= 3 ? "FLUTTER" : "PEACE")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        Image(passwordSettingViewModel.passwordFieldArray.count >= 4 ? "FLUTTER" : "PEACE")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                    
                }.padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 30))
                
                Spacer()
                
                LazyVGrid(columns: columns) {
                    ForEach((1...12), id: \.self) { numberpadNumber in
                        if numberpadNumber != 10 && numberpadNumber != 11 && numberpadNumber != 12 {
                            Button {
                                DispatchQueue.main.async {
                                    passwordSettingViewModel.passwordFieldArray.append(numberpadNumber)
                                }
                            } label: {
                                Text("\(numberpadNumber)")
                                    .foregroundColor(Color.black)
                            }
                            
                            
                        } else if numberpadNumber == 10 {
                            
                            Button {
                                DispatchQueue.main.async {
                                    passwordSettingViewModel.resetPasswordArray()
                                }
                            } label: {
                                Image(systemName: "arrow.clockwise")
                                    .foregroundColor(Color.gray)
                            }
                            
                        } else if numberpadNumber == 11 {
                            Button{
                                passwordSettingViewModel.passwordFieldArray.append(0)
                            } label: {
                                Text("0")
                                    .foregroundColor(Color.black)
                            }
                            
                            
                        } else if numberpadNumber == 12 {
                            Button {
                                DispatchQueue.main.async {
                                    passwordSettingViewModel.deleteLastIndexPasswordArray()
                                }
                            } label: {
                                Image(systemName: "delete.left.fill")
                                    .foregroundColor(Color.gray)
                            }
                        }
                    }
                    .padding()
                }
                .font(.largeTitle)
                
                
                Spacer()
                
            }
            .onAppear {
                passwordSettingViewModel.setObserver()
            }
            .onChange(of: passwordSettingViewModel.isPasswordRegisterFinish) {
                if passwordSettingViewModel.isPasswordRegisterFinish {
                    stateManager.isPasswordSettingView.toggle()
                }
            }
        }
    }
}
#Preview {
    PasswordSettingView().environmentObject(StateManager())
}
