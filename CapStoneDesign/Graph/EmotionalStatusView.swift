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
                                    .frame(width: 70, height: 70)
                            })
                            Spacer()
                            
                            Text("MoodMingle")
                                .font(.custom("KyoboHandwriting2021sjy", size: 25))
                                .padding(EdgeInsets(top: 0, leading: -70, bottom: 0, trailing: 0))
                            Spacer()
                        }
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                        .sheet(isPresented: $isPresented, content: {
                            EmotionGraphIntroView()
                        })
                        
                        HStack{
                            
                            Button(action: {
                                self.currentDate = Calendar.current.date(byAdding: .month, value: -1, to: self.currentDate)!
                            }, label: {
                                Image("arrow_left")
                            })
                            
                            Text("\(formattedYear(date: currentDate))")
                                .font(.custom("KyoboHandwriting2021sjy",size: 25))
                                .frame(width: 100, height: 70)
                                .multilineTextAlignment(.center)
                            
                            Button(action: {
                                self.currentDate = Calendar.current.date(byAdding: .month, value: +1, to: self.currentDate)!
                            }, label: {
                                Image("arrow_right")
                            })
                        }
                        
                    
                        Chart(vm, id: \.date) { element in
                            SectorMark(angle: .value("emotions", element.value) ,innerRadius: .ratio(0.618),
                                       angularInset: 1.5)
                            .cornerRadius(5)
                            .foregroundStyle(element.color)
                        }
                        .frame(width: geo.size.width * 0.8)
                        .chartBackground { chartProxy in
                            GeometryReader{ geometry in
                                let frame = geometry[chartProxy.plotAreaFrame]
                                VStack{
                                    
                                    let maxValueGraph = vm.max(by: { $0.value < $1.value }) // 최고값 찾기
                                    
                                    Text("주된 감정")
                                        .font(.custom("777Balsamtint", size: geo.size.width * 0.06))
                                        .foregroundStyle(.secondary)
                                    Text("\(maxValueGraph?.date ?? "")")
                                        .font(.custom("777Balsamtint", size: geo.size.width * 0.07))
                                }
                                .position(x: frame.midX, y: frame.midY)
                            }
                        }
                        
                        
                        ScrollView(.horizontal){
                            LazyVGrid(columns: layout){
                                ForEach(vm.indices, id: \.self){ emotion in
                                    Circle()
                                        .foregroundColor(vm[emotion].color)
                                        .frame(width: geo.size.width * 0.06)
                                    Text("\(vm[emotion].date)")
                                        .font(.custom("777Balsamtint", size: geo.size.width * 0.06))
                                        .frame(width: geo.size.width * 0.3)
                                }
                            }
                            .padding(.trailing, 10)
                        }
                        .frame(width: geo.size.width * 0.8)
                        
                        Spacer()
                        
                        Rectangle()
                            .frame(height: geo.size.height * 0.1)
                            .foregroundColor(.clear)
                    }
                }
            }
            .toolbar(.hidden)
            .navigationBarBackButtonHidden(true)
            .onAppear {
                // Transform GraphResponse data to Case2 format
                self.vm = transformGraphResponseToGraph()
                self.maxValue = self.vm.map { $0.value }.max() ?? 0 // 최고값 찾기
            }
        }
    }
    
    
    struct Graph {
        let date: String
        let value: Int
        let color: Color // 데이터 포인트에 대한 색상 추가
    }
    
    func transformGraphResponseToGraph() -> [Graph] {
        let graphResponse = GraphResponse(fear: 3, moved: 7, lethargy: 1, flutter: 8, peace: 9, pleasure: 10, confidence: 6, worry: 2, anger: 4, sadness: 5)
        
        
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
    EmotionalStatusView()
}
