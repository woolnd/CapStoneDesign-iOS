//
//  CalendarDateView.swift
//  CapStoneDesign
//
//  Created by Wodnd on 4/8/24.
//

import SwiftUI

struct CalendarDetailView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var isPresented: Bool = false
    
    @State var memberId: Int
    @State var diaryId: Int
    @State var date: Int
    @Binding var currentDate: Date
    
    let service = Service()
    @ObservedObject var viewModel: DiaryViewModel
    
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
                                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                                
                            })
                            
                            Spacer()
                            
                            Text("MoodMingle")
                                .font(.custom("KyoboHandwriting2021sjy", size: 25))
                                .padding(EdgeInsets(top: 0, leading: 40, bottom: 0, trailing: 0))
                            
                            Spacer()
                            
                            Button(action: {
                                isPresented = true
                            }, label: {
                                Image("introduce")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 70,height: 70)
                            })
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                        }
                        
                        ZStack{
                            Image("input_background")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding(EdgeInsets(top: -20, leading: 0, bottom: 0, trailing: 10))
                            
                            HStack{
                                VStack{
                                    
                                    HStack{
                                        Text("날짜: \(formattedDate)")
                                            .font(.custom("777Balsamtint", size: geo.size.width * 0.05))
                                    }
                                    
                                    HStack{
                                        Text("감정: 감정")
                                            .font(.custom("777Balsamtint", size: geo.size.width * 0.05))
                                            .padding(EdgeInsets(top: 17, leading: 0, bottom: 0, trailing: 0))
                                        
                                        Image("PLEASURE")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: geo.size.width * 0.16)
                                    }
                                    
                                    HStack{
                                        Text("날씨: 날씨")
                                            .font(.custom("777Balsamtint", size: geo.size.width * 0.05))
                                            .padding(EdgeInsets(top: 17, leading: 0, bottom: 0, trailing: 0))
                                        
                                        Image("SUNNY_1")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: geo.size.width * 0.16)
                                            .clipped()
                                    }
                                    
                                    Spacer()
                                }
                                
                                
                            }
                            .offset(CGSize(width: geo.size.width * 0.22, height: geo.size.height * 0.025))
                            
                            ScrollView(.horizontal){
                                Text("제목")
                                    .font(.custom("777Balsamtint", size: geo.size.width * 0.06))
                            }
                            .frame(width: geo.size.width * 0.6)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: geo.size.width * 0.3, trailing: 0))
                            
                            
                            ScrollView(.vertical){
                                Text("내용이 들어갈 자리 입니다람쥐내용이 들어갈 자리 입니다람쥐내용이 들어갈 자리 입니다람쥐내용이 들어갈 자리 입니다람쥐내용이 들어갈 자리 입니다람쥐내용이 들어갈 자리 입니다람쥐내용이 들어갈 자리 입니다람쥐내용이 들어갈 자리 입니다람쥐내용이 들어갈 자리 입니다람쥐내용이 들어갈 자리 입니다람쥐내용이 들어갈 자리 입니다람쥐내용이 들어갈 자리 입니다람쥐내용이 들어갈 자리 입니다람쥐내용이 들어갈 자리 입니다람쥐내용이 들어갈 자리 입니다람쥐")
                                    .font(.custom("777Balsamtint", size: geo.size.width * 0.05))
                            }
                            .frame(width: geo.size.width * 0.9, height: geo.size.height * 0.3)
                            .padding(EdgeInsets(top: geo.size.height * 0.35, leading: 0, bottom: 0, trailing: 0))
                        }
                        
                    }
                }
            }
            .accentColor(Color.black)
        }
        .toolbar(.hidden)
        .navigationBarBackButtonHidden(true)
        .sheet(isPresented: $isPresented, content: {
            DiaryIntroView()
        })
        .onAppear(){
            loadDiaryData()
        }
    }
    
    private func loadDiaryData() {
        service.DiaryDetailRequest(dto: DiaryDetailRequest(dto: Diary(memberId: memberId, diaryId: diaryId))) { result in
            switch result {
            case .success(let response):
                if let diaryResponse = response.first {
                    let diaryModel = DiaryViewModel.DiaryModel(
                        diaryId: diaryResponse.diaryId,
                        title: diaryResponse.title,
                        content: diaryResponse.content,
                        date: diaryResponse.date,
                        emotion: diaryResponse.emotion,
                        weather: diaryResponse.weather,
                        imageUrl: diaryResponse.imageUrl,
                        replyContent: diaryResponse.replyContent,
                        type: diaryResponse.type
                    )
                    viewModel.updateDiary(with: diaryModel)
                    print("\(diaryResponse)")
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM"
        let day: String
        if(date < 10){
            day = "0\(date)"
        }
        else{
            day = "\(date)"
        }
        
        return "\(formatter.string(from: currentDate)).\(day)"
    }
}

#Preview {
    CalendarDetailView(memberId: 1, diaryId: 8, date: 1, currentDate: .constant(Date()), viewModel: DiaryViewModel(diary: DiaryViewModel.mock))
}
