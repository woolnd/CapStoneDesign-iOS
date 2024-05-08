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
    var service = Service()
    
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
                    .padding(EdgeInsets(top: 20, leading: 0, bottom: 30, trailing: 0))
                    
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
                    service.diaryRequest { result in
                        switch result {
                        case .success(let response):
                            // 성공적으로 응답을 받았을 때 수행할 동작
                            print("Diary response: \(response)")
                        case .failure(let error):
                            // 요청이 실패했을 때 수행할 동작
                            print("Error: \(error)")
                        }
                    }
                    
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
