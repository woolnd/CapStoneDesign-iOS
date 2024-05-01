//
//  AppScreenLockView.swift
//  CapStoneDesign
//
//  Created by Wodnd on 5/2/24.
//

import SwiftUI

struct AppScreenLockView: View {
    @EnvironmentObject var appScreenLockModel : AppScreenLockViewModel
    @EnvironmentObject var stateManager : StateManager
    private var placeHolder : String = "비밀번호를 입력해주세요"
    @State var textfiledText : String = ""
    
    
    var columns: [GridItem] =
    Array(repeating: .init(.flexible()), count: 3)
    
    
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
                    
                    Text("비밀번호를 입력해주세요")
                        .font(.custom("777Balsamtint", size: 35))
                        .padding(EdgeInsets(top: 25, leading: 0, bottom: 0, trailing: 0))
                    
                    Spacer()
                }
                
                
                Spacer()
                
                
                HStack(spacing: 10){
                    Group {
                        Image(appScreenLockModel.passwordFieldArray.count >= 1 ? "flutter" : "peace")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        Image(appScreenLockModel.passwordFieldArray.count >= 2 ? "flutter" : "peace")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        Image(appScreenLockModel.passwordFieldArray.count >= 3 ? "flutter" : "peace")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        Image(appScreenLockModel.passwordFieldArray.count >= 4 ? "flutter" : "peace")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                    
                }.padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 30))
                
                .offset(x: appScreenLockModel.isWrongPassword ? -10 : 0)
                .animation(appScreenLockModel.isWrongPassword ?  Animation.default.repeatCount(3).speed(6) : .none)
                
                Text("비밀번호를 잊어버렸어요")
                    .font(.system(size: 14, weight: .regular, design: .serif))
                    .underline()
                    .padding(.bottom, 79)
                    .foregroundColor(Color.gray)
                    .contentShape(Rectangle())
                    .onTapGesture(perform: {
                        stateManager.isForgetPasswordState.toggle()
                    })
                    .sheet(isPresented: $stateManager.isForgetPasswordState) {
                        //비밀번호 초기화 화면
                    }
                
                
                Spacer()
                
                LazyVGrid(columns: columns) {
                    ForEach((1...12), id: \.self) { numberpadNumber in
                        if numberpadNumber != 10 && numberpadNumber != 11 && numberpadNumber != 12 {
                            Button {
                                DispatchQueue.main.async {
                                    appScreenLockModel.passwordFieldArray.append(numberpadNumber)
                                    print("\(appScreenLockModel.passwordFieldArray)")
                                }
                            } label: {
                                Text("\(numberpadNumber)")
                                    .padding(.bottom, 32)
                                    .contentShape(Rectangle())
                                    .foregroundColor(Color.black)
                            }
                            
                            
                        } else if numberpadNumber == 10 {
                            
                            Button {
                                DispatchQueue.main.async {
                                    appScreenLockModel.resetPasswordArray()
                                }
                            } label: {
                                Image(systemName: "arrow.clockwise")
                                    .foregroundColor(Color.gray)
                                    .contentShape(Rectangle())
                            }
                            
                        } else if numberpadNumber == 11 {
                            Button{
                                appScreenLockModel.passwordFieldArray.append(0)
                            } label: {
                                Text("0")
                                    .contentShape(Rectangle())
                                    .foregroundColor(Color.gray)
                            }
                            
                            
                        } else if numberpadNumber == 12 {
                            Button {
                                DispatchQueue.main.async {
                                    appScreenLockModel.deleteLastIndexPasswordArray()
                                }
                            } label: {
                                Image(systemName: "delete.left.fill")
                                    .contentShape(Rectangle())
                                    .foregroundColor(Color.gray)
                            }
                        }
                    }
                }
                .font(.largeTitle)
                
                
                Spacer()
                
            }
            .onAppear {
                appScreenLockModel.setObserver()
            }
        }
    }
}

#Preview {
    AppScreenLockView().environmentObject(AppScreenLockViewModel()).environmentObject(StateManager())
}
