//
//  DiarySendView.swift
//  CapStoneDesign
//
//  Created by Wodnd on 4/28/24.
//

import SwiftUI

struct DiarySendView: View {
    
    @State var requestBody: DiaryDto
    @State var currentResponse: Int
    
    var service = Service()
    
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
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: geo.size.width * 0.1, trailing: 20))
                    }
                }
                .onAppear(){
                    switch currentResponse{
                    case 0:
                        print("0")
                        service.LetterRequest(letter: requestBody) { result in
                            switch result {
                            case .success(let response):
                                // 성공적으로 응답을 받았을 때 수행할 동작
                                print("Diary response: \(response)")
                            case .failure(_): break
                                // 요청이 실패했을 때 수행할 동작
                            }
                        }
                    case 1:
                        print("1")
                        service.SympathyRequest(sympathy: requestBody) { result in
                            switch result {
                            case .success(let response):
                                // 성공적으로 응답을 받았을 때 수행할 동작
                                print("Diary response: \(response)")
                            case .failure(_): break
                                // 요청이 실패했을 때 수행할 동작
                            }
                        }
                    case 2:
                        print("2")
                        service.AdviceRequest(advice: requestBody) { result in
                            switch result {
                            case .success(let response):
                                // 성공적으로 응답을 받았을 때 수행할 동작
                                print("Diary response: \(response)")
                            case .failure(_): break
                                // 요청이 실패했을 때 수행할 동작
                            }
                        }
                    default:
                        break
                    }
                }
            }
            .toolbar(.hidden)
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    DiarySendView(requestBody: DiaryDto(dto: Dto(title: "", date: "", content: "", emotion: "", weather: ""), image: ""), currentResponse: 0)
}
