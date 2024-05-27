//
//  EmotionalStatusView.swift
//  CapStoneDesign
//
//  Created by Wodnd on 4/10/24.
//

import SwiftUI
import Charts

struct Case2 {
    let date: Int
    let value: Int
    
}

struct EmotionalStatusView: View {
    
    @State var isPresented: Bool = false
    @State var vm: [Graph] = []
    @State var currentDate: Date = Date()
    @State var maxValue: Int = 0 // 최고값
    
    let service = Service()
    @ObservedObject var viewModel: EmotionStatusViewModel
    
    
    var layout: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        GeometryReader{ geo in
            NavigationStack{
                ZStack {
                    Image("initial_background")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .ignoresSafeArea()
                    
                    VStack{
                        HStack{
                            Button(action: {
                                isPresented = true
                            }, label: {
                                Image("introduce")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geo.size.width * 0.18)
                            })
                            .padding(EdgeInsets(top: 0, leading: geo.size.width * 0.05, bottom: 0, trailing: 0))
                            
                            Spacer()
                            
                            Text("MoodMingle")
                                .font(.custom("KyoboHandwriting2021sjy", size: geo.size.width * 0.05))
                            Spacer()
                            
                            Rectangle()
                                .frame(width: geo.size.width * 0.18, height: geo.size.width * 0.18)
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: geo.size.width * 0.05))
                                .foregroundColor(.clear)
                            
                        }
                        .sheet(isPresented: $isPresented, content: {
                            EmotionGraphIntroView()
                        })
                        
                        HStack{
                            
                            Button(action: {
                                let newDate = Calendar.current.date(byAdding: .month, value: -1, to: self.currentDate)!
                                if newDate >= Calendar.current.date(from: DateComponents(year: 2024, month: 5))! {
                                    self.currentDate = newDate
                                    loadEmotionData()
                                }
                            }, label: {
                                Image("arrow_left")
                            })
                            
                            Text("\(formattedYear(date: currentDate))")
                                .font(.custom("KyoboHandwriting2021sjy",size: 25))
                                .frame(width: 100, height: 70)
                                .multilineTextAlignment(.center)
                            
                            Button(action: {
                                self.currentDate = Calendar.current.date(byAdding: .month, value: +1, to: self.currentDate)!
                                loadEmotionData()
                            }, label: {
                                Image("arrow_right")
                            })
                        }
                        .padding(EdgeInsets(top: -geo.size.width * 0.01, leading: 0, bottom: 0, trailing: 0))
                        
                        Chart(vm, id: \.date) { element in
                            SectorMark(angle: .value("emotions", element.value) ,innerRadius: .ratio(0.618),
                                       angularInset: 1.5)
                            .cornerRadius(5)
                            .foregroundStyle(element.color)
                        }
                        .frame(width: geo.size.width * 0.7)
                        .chartBackground { chartProxy in
                            GeometryReader{ geometry in
                                let frame = geometry[chartProxy.plotAreaFrame]
                                VStack {
                                    let allValues = vm.map { $0.value }
                                    let maxValueGraph = vm.max(by: { $0.value < $1.value }) // 최고값 찾기
                                    
                                    let isAllValuesEqual = allValues.allSatisfy { $0 == allValues.first }
                                    let maxValueCount = allValues.filter { $0 == maxValue }.count
                                    
                                    let areAllValuesZero = allValues.allSatisfy { $0 == 0 }
                                    
                                    Text("주된 감정")
                                        .font(.custom("777Balsamtint", size: geo.size.width * 0.06))
                                        .foregroundStyle(.secondary)
                                    Text(areAllValuesZero ? "감정이 없음" : (isAllValuesEqual || maxValueCount > 1 ? "없음" : "\(maxValueGraph?.date ?? "")"))
                                        .font(.custom("777Balsamtint", size: geo.size.width * 0.06))
                                }
                                .position(x: frame.midX, y: frame.midY)
                            }
                        }
                        
                        
                        ScrollView(.horizontal){
                            LazyVGrid(columns: layout){
                                ForEach(vm.indices, id: \.self){ emotion in
                                    Circle()
                                        .foregroundColor(vm[emotion].color)
                                        .frame(width: geo.size.width * 0.05)
                                    Text("\(vm[emotion].date)")
                                        .font(.custom("777Balsamtint", size: geo.size.width * 0.05))
                                        .frame(width: geo.size.width * 0.3)
                                }
                            }
                            .padding(.trailing, 10)
                        }
                        .frame(width: geo.size.width * 0.7)
                        
                        Spacer()
                        
                        Rectangle()
                            .frame(height: geo.size.height * 0.2)
                            .foregroundColor(.clear)
                    }
                    
                }
            }
            .toolbar(.hidden)
            .navigationBarBackButtonHidden(true)
            .onAppear {
                loadEmotionData()
            }
        }
        
    }
    private func loadEmotionData() {
        service.EmotionRequest(dtos: DiaryRequest(dto: MonthDto(date: "\(formattedApi(date: currentDate))"))) { result in
            switch result {
            case .success(let response):
                let emotionModel = EmotionStatusViewModel.Emotions(
                    fear: response.fear,
                    moved: response.moved,
                    lethargy: response.lethargy,
                    flutter: response.flutter,
                    peace: response.peace,
                    pleasure: response.pleasure,
                    confidence: response.confidence,
                    worry: response.worry,
                    anger: response.anger,
                    sadness: response.sadness)
                viewModel.updateEmotion(with: emotionModel)
                self.vm = transformGraphResponseToGraph()
                self.maxValue = self.vm.map { $0.value }.max() ?? 0 // 최고값 찾기
                
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    private func formattedApi(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM"
        return formatter.string(from: date)
    }
    
    struct Graph {
        let date: String
        let value: Int
        let color: Color // 데이터 포인트에 대한 색상 추가
    }
    
    func transformGraphResponseToGraph() -> [Graph] {
        let graphResponse = viewModel.emotion
        
        
        return [
            Graph(date: "기쁨", value: graphResponse.pleasure, color: Color.pleasure),
            Graph(date: "평온", value: graphResponse.peace, color: Color.peace),
            Graph(date: "설렘", value: graphResponse.flutter, color: Color
                .flutter),
            Graph(date: "감동", value: graphResponse.moved, color: Color.moved),
            Graph(date: "자신감", value: graphResponse.confidence, color: Color.confidence),
            Graph(date: "우울", value: graphResponse.sadness, color: Color.sadness),
            Graph(date: "분노", value: graphResponse.anger, color:Color.anger),
            Graph(date: "공포", value: graphResponse.fear, color: Color.fear),
            Graph(date: "걱정", value: graphResponse.worry, color:Color.worry),
            Graph(date: "무기력", value: graphResponse.lethargy, color: Color.lethargy),
        ]
    }
    
    private func formattedYear(date: Date) -> String{
        let yearFormatter = DateFormatter()
        yearFormatter.dateFormat = "yyyy"
        
        let monthFormatter = DateFormatter()
        monthFormatter.dateFormat = "MMMM"
        
        let yearString = yearFormatter.string(from: date)
        let monthString = monthFormatter.string(from: date)
        
        return "\(yearString)\n\(monthString)"
    }
    
    private func formattedDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
}


#Preview {
    EmotionalStatusView(viewModel: EmotionStatusViewModel(emotion: EmotionStatusViewModel.mock))
}
