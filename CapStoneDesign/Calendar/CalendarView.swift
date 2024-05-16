//
//  test.swift
//  CapStoneDesign
//
//  Created by Wodnd on 4/11/24.
//

import SwiftUI

struct CalendarView: View {
    
    @State var isPresented: Bool = false
    @ObservedObject var viewModel: CalendarViewModel
    @State var currentDate: Date = Date()
    @State var selectionDate = 0
    let service = Service()
    
    let week: [String] = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"]
    
    let layout: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
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
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: geo.size.width * 0.2))
                            Spacer()
                        }
                        
                        Spacer()
                        
                        HStack{
                            
                            Button(action: {
                                self.currentDate = Calendar.current.date(byAdding: .month, value: -1, to: self.currentDate)!
                                loadDiaryData()
                            }, label: {
                                Image("arrow_left")
                            })
                            
                            
                            Text("\(formattedYear(date: currentDate))")
                                .font(.custom("KyoboHandwriting2021sjy",size: 25))
                                .frame(width: 100, height: 70)
                                .multilineTextAlignment(.center)
                            
                            Button(action: {
                                self.currentDate = Calendar.current.date(byAdding: .month, value: +1, to: self.currentDate)!
                                loadDiaryData()
                            }, label: {
                                Image("arrow_right")
                            })
                        }
                        
                        ZStack{
                            VStack{
                                Image("calendar_background")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geo.size.width * 1)
                                
                                Spacer()
                            }
                            
                            VStack{
                                LazyVGrid(columns: layout){
                                    ForEach(week, id: \.self){ week in
                                        Text("\(week)")
                                            .font(.custom("KyoboHandwriting2021sjy",size: 18))
                                            .foregroundColor(week == "SUN" || week == "SAT" ? Color("Orange") : Color("LightGray"))
                                    }
                                }
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                                
                                LazyVGrid(columns: layout){
                                    ForEach(daysInMonth(date: currentDate), id: \.self) { day in
                                        NavigationLink(destination: destinationView(for: day)) {
                                            CalendarDateView(viewModel: viewModel, date: day, currentDate: $currentDate)
                                                .frame(height: geo.size.height * 0.08)
                                        }
                                        .onTapGesture {
                                            loadDiaryData()
                                        }

                                    }
                                }
                                Spacer()
                                
                            }
                            .padding()
                            
                            Spacer()
                        }
                        
                        Spacer()
                    }
                }
            }
            .toolbar(.hidden)
            .navigationBarBackButtonHidden(true)
            .sheet(isPresented: $isPresented, content: {
                CalendarIntroView()
            })
        }
        .onAppear(){
            loadDiaryData()
        }
    }
    private func loadDiaryData() {
        service.DiaryRequest(dto: DiaryRequest(dto: MonthDto(memberId: 1, date: "\(formattedApi(date: currentDate))"))) { result in
            switch result {
            case .success(let response):
                let diaryModels = response.map { CalendarViewModel.CalendarModel(diaryId: $0.diaryId, date: $0.date, emotion: $0.emotion) }
                viewModel.updateDiary(with: diaryModels)
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    private func destinationView(for day: Int) -> AnyView {
        if let diaryModel = diaryForDay(day) {
            return AnyView(CalendarDetailView(memberId: 1, diaryId: diaryModel.diaryId, date: day, currentDate: $currentDate, viewModel: DiaryViewModel(diary: DiaryViewModel.mock)))
        } else {
            return AnyView(EmotionInputView(date: day, currentDate: $currentDate))
        }
    }
    
    private func diaryForDay(_ day: Int) -> CalendarViewModel.CalendarModel? {
        let dateString = "\(formattedyear(date: currentDate))-\(formattedMonth(date: currentDate))-\(String(format: "%02d", day))"
        return viewModel.diary.first { $0.date == dateString }
    }
}

extension CalendarView{
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
    
    private func formattedApi(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM"
        return formatter.string(from: date)
    }
    
    private func formattedyear(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter.string(from: date)
    }
    
    private func formattedMonth(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM"
        return formatter.string(from: date)
    }
    
    
    private func daysInMonth(date: Date) -> [Int] {
        let calendar = Calendar.current
        let monthRange = calendar.range(of: .day, in: .month, for: date)!
        let firstDayOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: date))!
        var firstWeekdayOfMonth = calendar.component(.weekday, from: firstDayOfMonth)
        
        firstWeekdayOfMonth -= 1
        var days: [Int] = Array(1...monthRange.count)
        for _ in 0..<(firstWeekdayOfMonth % 7) {
            days.insert(0, at: 0)
        }
        
        return days
    }
    
}

#Preview {
    CalendarView(viewModel: CalendarViewModel(diary: CalendarViewModel.mock))
}
