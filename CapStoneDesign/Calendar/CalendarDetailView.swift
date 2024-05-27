//
//  CalendarDateView.swift
//  CapStoneDesign
//
//  Created by Wodnd on 4/8/24.
//

import SwiftUI
import Kingfisher

struct CalendarDetailView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var isPresented: Bool = false
    
    @State var diaryId: Int
    @State var date: Int
    @Binding var currentDate: Date
    @State private var isShowingFullImage = false
    @State private var isShowingResponse = false
    
    let service = Service()
    @ObservedObject var viewModel: DiaryViewModel
    
    private func emotionInKorean(_ emotion: String) -> String {
        switch emotion {
        case "PLEASURE":
            return "기쁨"
        case "PEACE":
            return "평온"
        case "FLUTTER":
            return "설렘"
        case "MOVED":
            return "감동"
        case "CONFIDENCE":
            return "자신감"
        case "SADNESS":
            return "우울"
        case "ANGER":
            return "분노"
        case "FEAR":
            return "공포"
        case "WORRY":
            return "걱정"
        case "LETHARGY":
            return "무기력"
            // 다른 감정에 대한 케이스 추가
        default:
            return emotion // 기본적으로는 원래의 영어 감정을 반환
        }
    }
    
    private func weatherInKorean(_ weather: String) -> String {
        switch weather {
        case "SUNNY":
            return "맑음"
        case "CLOUDY":
            return "흐림"
        case "RAINY":
            return "비"
            // 다른 감정에 대한 케이스 추가
        default:
            return weather // 기본적으로는 원래의 영어 감정을 반환
        }
    }
    
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
                            
                            
                            
                            Spacer()
                            
                            Rectangle()
                                .frame(width: geo.size.width * 0.13, height: geo.size.width * 0.18)
                                .foregroundColor(.clear)
                        }
                        
                        ZStack{
                            Image("input_background")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geo.size.width * 0.95)
                                .padding(EdgeInsets(top: -20, leading: 0, bottom: 0, trailing: geo.size.width * 0.04))
                            
                            HStack{
                                VStack{
                                
                                    HStack{
                                        Text("날짜: \(formattedDate)")
                                            .font(.custom("777Balsamtint", size: geo.size.width * 0.05))
                                    }
                                    
                                    HStack{
                                        Text("감정: \(emotionInKorean(viewModel.diary.emotion))")
                                            .font(.custom("777Balsamtint", size: geo.size.width * 0.05))
                                            .padding(EdgeInsets(top: 17, leading: 0, bottom: 0, trailing: 0))
                                        
                                        Image("\(viewModel.diary.emotion)")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: geo.size.width * 0.16)
                                    }
                                    
                                    HStack{
                                        Text("날씨: \(weatherInKorean(viewModel.diary.weather))")
                                            .font(.custom("777Balsamtint", size: geo.size.width * 0.05))
                                            .padding(EdgeInsets(top: 17, leading: 0, bottom: 0, trailing: 0))
                                        
                                        Image("\(viewModel.diary.weather)_1")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: geo.size.width * 0.16)
                                            .clipped()
                                    }
                                    
                                    Spacer()
                                }
                                
                            }
                            .offset(CGSize(width: geo.size.width * 0.22, height: geo.size.height * 0.025))
                            
                            HStack{
                                VStack{
                                    if viewModel.diary.imageUrl == nil {
                                        Image("\(viewModel.diary.emotion)")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: geo.size.width * 0.4, height: geo.size.width * 0.5)
                                            .clipped()
                                            .cornerRadius(20)
                                            .padding(EdgeInsets(top: geo.size.width * 0.1, leading: geo.size.width * 0.06, bottom: 0, trailing: 0))
                                    }else{
                                        let url = URL(string: viewModel.diary.imageUrl ?? "")
                                        KFImage(url)
                                            .onSuccess { result in
                                                print("\(result)")
                                            }
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: geo.size.width * 0.4, height: geo.size.width * 0.5)
                                            .clipped()
                                            .cornerRadius(20)
                                            .padding(EdgeInsets(top: geo.size.width * 0.1, leading: geo.size.width * 0.06, bottom: 0, trailing: 0))
                                    }
                                    
                                    
                                    Button(action: {
                                        isShowingFullImage.toggle()
                                    }, label: {
                                        Text("전체 사진보기")
                                            .font(.custom("777Balsamtint", size: geo.size.width * 0.05))
                                    })
                                    .padding(EdgeInsets(top: -geo.size.width * 0.01, leading: geo.size.width * 0.05, bottom: 0, trailing: 0))
                                    .sheet(isPresented: $isShowingFullImage, content: {
                                        ZStack {
                                            
                                            if viewModel.diary.imageUrl == nil {
                                                Image("\(viewModel.diary.emotion)")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .edgesIgnoringSafeArea(.all)
                                                
                                            }else{
                                                let url = URL(string: viewModel.diary.imageUrl ?? "")
                                                KFImage(url)
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .edgesIgnoringSafeArea(.all)
                                            }
                                        }
                                    })
                                    
                                }
                                .padding(EdgeInsets(top: -geo.size.width * 0.96, leading: 0, bottom: 0, trailing: 0))
                                Spacer()
                                
                            }
                            
                            ScrollView(.horizontal){
                                Text("\(viewModel.diary.title)")
                                    .font(.custom("777Balsamtint", size: geo.size.width * 0.06))
                            }
                            .frame(width: geo.size.width * 0.6)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: geo.size.width * 0.3, trailing: geo.size.width * 0.04))
                            
                            
                            ScrollView(.vertical){
                                Text("\(viewModel.diary.content)")
                                    .font(.custom("777Balsamtint", size: geo.size.width * 0.05))
                            }
                            .frame(width: geo.size.width * 0.9, height: geo.size.height * 0.3)
                            .padding(EdgeInsets(top: geo.size.height * 0.35, leading: 0, bottom: 0, trailing: geo.size.width * 0.04))
                            
                            VStack{
                                Spacer()
                                
                                if viewModel.diary.replyContent != nil{
                                    Button(action: {
                                        isShowingResponse = true
                                    }, label: {
                                        Image("response_btn")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: geo.size.width * 0.9)
                                    })
                                }
                                else{
                                    Button(action: {
                                        isShowingResponse = true
                                    }, label: {
                                        Image("response_btn_off")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: geo.size.width * 0.9)
                                    })
                                }
                                
                            }.padding(EdgeInsets(top: 0, leading: 0, bottom: geo.size.width * 0.1, trailing: geo.size.width * 0.04))
                        }
                        
                    }
                    
                    VStack{
                    
                        HStack{
                            
                            Button(action: {
                                self.presentationMode.wrappedValue.dismiss()
                            }, label: {
                                
                                Image(systemName: "chevron.left")
                                    .resizable()// 화살표 Image
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geo.size.width * 0.04)
                            })
                            .padding(EdgeInsets(top: 0, leading: geo.size.width * 0.05, bottom: 0, trailing: 0))
                            .zIndex(1)
                            
                            Spacer()
                            
                            Text("MoodMingle")
                                .font(.custom("KyoboHandwriting2021sjy", size: geo.size.width * 0.05))
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: -geo.size.width * 0.1))
                            
                            Spacer()
                            
                            Button(action: {
                                isPresented = true
                            }, label: {
                                Image("introduce")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geo.size.width * 0.18, height: geo.size.width * 0.18)
                            })
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: geo.size.width * 0.05))
                        }
                        Spacer()
                    }
                }
                .accentColor(Color.black)
            }
            .toolbar(.hidden)
            .navigationBarBackButtonHidden(true)
        }
        
        .sheet(isPresented: $isPresented, content: {
            DiaryIntroView()
        })
        .sheet(isPresented: $isShowingResponse, content: {
            DiaryResponseView(responseType: viewModel.diary.type ?? "", content: viewModel.diary.replyContent ?? "")
        })
        .onAppear(){
            loadDetailData()
        }
    }
    
    private func loadDetailData() {
        
        service.DiaryDetailRequest(dtos: DiaryDetailRequest(dto: Diary(diaryId: diaryId))) { result in
            switch result {
            case .success(let response):
                let diaryModel = DiaryViewModel.DiaryModel(
                    diaryId: response.diaryId,
                    title: response.title,
                    content: response.content,
                    date: response.date,
                    emotion: response.emotion,
                    weather: response.weather,
                    imageUrl: response.imageUrl,
                    replyContent: response.replyContent,
                    type: response.type
                )
                viewModel.updateDiary(with: diaryModel)
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
    CalendarDetailView(diaryId: 2, date: 1, currentDate: .constant(Date()), viewModel: DiaryViewModel(diary: DiaryViewModel.mock))
}
