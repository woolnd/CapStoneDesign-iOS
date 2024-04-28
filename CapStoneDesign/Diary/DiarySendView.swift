//
//  DiarySendView.swift
//  CapStoneDesign
//
//  Created by Wodnd on 4/28/24.
//

import SwiftUI

struct DiarySendView: View {
    
    @Binding var title: String
    @Binding var content: String
    
    var body: some View {
        NavigationStack{
            ZStack{
                Image("initial_background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                
                VStack{
                    
                    HStack{
                        Text("MoodMingle")
                            .font(.custom("KyoboHandwriting2021sjy", size: 25))
                    }
                    .padding(EdgeInsets(top: 15, leading: 0, bottom: 30, trailing: 0))
                    
                    Text("등록완료!")
                        .font(.custom("777Balsamtint", size: 35))
                    
                    Spacer()
                    
                    Image("send")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding()
                    
                    Spacer()
                    
                    HStack{
                        NavigationLink {
                            TabBarView(selection: 1)
                        } label: {
                            Image("main_btn")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                        
                        NavigationLink {
                            TabBarView(selection: 0)
                        } label: {
                            Image("emotiongraph_btn")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                    }
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                }
                .onAppear{
                    print("\(title)")
                    print("\(content)")
                }
                
            }
        }
        .toolbar(.hidden)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    DiarySendView(title: .constant("제목입니다"), content: .constant("내용입니다"))
}
