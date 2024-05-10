//
//  ResponseView.swift
//  CapStoneDesign
//
//  Created by Wodnd on 5/11/24.
//

import SwiftUI

struct ResponseView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var selectedResponseIndex: Int?
    @State var currentDate: String
    @State var currentEmotion: Int
    

    
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
                                    .frame(width: 20, height: 20)
                                    .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 0))
                                
                            })
                            Spacer()
                            
                            Text("MoodMingle")
                                .font(.custom("KyoboHandwriting2021sjy", size: 25))
                                .padding(EdgeInsets(top: 0, leading: -50, bottom: 0, trailing: 0))
                            
                            Spacer()
                        }
                        .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
                        
                        Text("답변 방식을 선택해 주세요!")
                            .font(.custom("777Balsamtint", size: 35))
                            .padding()
                        
                        if currentEmotion == 1{
                            Image("letter")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geo.size.width * 0.8)
                                .onTapGesture {
                                    selectedResponseIndex = 1
                                }
                                .opacity(selectedResponseIndex != nil && selectedResponseIndex != 1  ? 0.5 : 1.0)
                            
                            Image("friend")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geo.size.width * 0.8)
                                .onTapGesture {
                                    selectedResponseIndex = 2
                                }
                                .opacity(selectedResponseIndex != nil && selectedResponseIndex != 2  ? 0.5 : 1.0)
                            
                            Image("advice")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geo.size.width * 0.8)
                                .onTapGesture {
                                    selectedResponseIndex = 3
                                }
                                .opacity(selectedResponseIndex != nil && selectedResponseIndex != 3  ? 0.5 : 1.0)
                        }
                        else{
                            Image("letter")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geo.size.width * 0.8)
                                .opacity(0.5)
                            
                            Image("friend")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geo.size.width * 0.8)
                                .onTapGesture {
                                    selectedResponseIndex = 2
                                }
                                .opacity(selectedResponseIndex != nil && selectedResponseIndex != 2  ? 0.5 : 1.0)
                            
                            Image("advice")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geo.size.width * 0.8)
                                .onTapGesture {
                                    selectedResponseIndex = 3
                                }
                                .opacity(selectedResponseIndex != nil && selectedResponseIndex != 3  ? 0.5 : 1.0)
                        }

                        Spacer()
                    }
                    
                    VStack{
                        Spacer()
                        
                        if selectedResponseIndex != nil {
                            NavigationLink {
                                DiaryInputView(currentDate: currentDate, currentEmotion: currentEmotion, currentResponse: selectedResponseIndex!)
                            } label: {
                                Image("emotion_btn_on")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geo.size.width * 0.9)
                            }

                        }else{
                            Image("emotion_btn_off")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geo.size.width * 0.9)
                        }
                        
                    }
                    
                }
                .accentColor(Color.black)
            }
            .toolbar(.hidden)
            .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    ResponseView(currentDate: "2024-04-18", currentEmotion: 0)
}
