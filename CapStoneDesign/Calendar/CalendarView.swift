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
    @State var current: Date = Date()
    @State var selectionDate = 0
    let service = Service()
    @State var showAlert : Bool = false
    
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
                            Spacer()
                            
                            Rectangle()
                                .frame(width: geo.size.width * 0.18, height: geo.size.width * 0.18)
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: geo.size.width * 0.05))
                                .foregroundColor(.clear)
                            
                        }
                        
                        Spacer()
                        
                        HStack{
                            
                            Button(action: {
                                let newDate = Calendar.current.date(byAdding: .month, value: -1, to: self.currentDate)!
                                if newDate >= Calendar.current.date(from: DateComponents(year: 2024, month: 5))! {
                                    
                                    self.currentDate = newDate
                                    viewModel.loadDiaryData(for: currentDate)
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
                                viewModel.loadDiaryData(for: currentDate)
                            }, label: {
                                Image("arrow_right")
                            })
                        }
                        
                        ZStack{
                            VStack{
                                Image("calendar_background")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                
                                Spacer()
                            }
                            
                            VStack{
                                LazyVGrid(columns: layout){
                                    ForEach(week, id: \.self){ week in
                                        Text("\(week)")
                                            .font(.custom("KyoboHandwriting2021sjy",size: 18))
                                            .foregroundColor(week == "SUN" || week == "SAT" ? Color("Week_Orange") : Color("Week_LightGray"))
                                    }
                                }
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 2, trailing: 0))
                                
                                
                                LazyVGrid(columns: layout){
                                    ForEach(daysInMonth(date: currentDate), id: \.1) { day in
                                        
                                    
                                        if day.0 != 0 {
                                            let select = formattedFuture(date: day.0)
                                            let current = isToday()
                                            
                                            if select ?? currentDate <= current ?? currentDate {
                                                NavigationLink(destination: destinationView(for: day.0)) {
                                                    CalendarDateView(viewModel: viewModel, date: day.0, currentDate: $currentDate)
                                                        .frame(width: geo.size.width * 0.12, height: geo.size.height * 0.078)
                                                }
                                            } else {
                                                Button(action: {
                                                    showAlert.toggle()
                                                }, label: {
                                                    CalendarDateView(viewModel: viewModel, date: day.0, currentDate: $currentDate)
                                                        .frame(width: geo.size.width * 0.12, height: geo.size.height * 0.078)
                                                })
                                            }
                                        } else {
                                            // day가 0인 경우 빈 뷰를 추가합니다.
                                            Color.clear.frame(width: geo.size.width * 0.12, height: geo.size.height * 0.078)
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
            .alert(isPresented: $showAlert) {
                Alert(title: Text("경고"), message: Text("미래 일기는 작성 불가"),
                      dismissButton: .default(Text("닫기")))
            }
        }
        .onAppear {
            viewModel.loadDiaryData(for: currentDate)
        }
    }
    
    private func formattedFuture(date: Int) -> Date? {
        
        let calendar = Calendar.current
        let currentMonth = calendar.component(.month, from: currentDate)
        let currentYear = calendar.component(.year, from: currentDate)
        
        return  dateFromString("\(currentYear)-\(currentMonth)-\(date)")
        
    }
    
    private func isToday() -> Date? {
        let calendar = Calendar.current
        let currentDay = calendar.component(.day, from: current)
        let currentMonth = calendar.component(.month, from: current)
        let currentYear = calendar.component(.year, from: current)
        
        return dateFromString("\(currentYear)-\(currentMonth)-\(currentDay)")
    }
    
    
    func dateFromString(_ dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-M-d"
        return dateFormatter.date(from: dateString)
    }
    
    private func destinationView(for day: Int) -> AnyView {
        print("\(day)")
        if let diaryModel = diaryForDay(day) {
            return AnyView(CalendarDetailView(diaryId: diaryModel.diaryId, date: day, currentDate: $currentDate, viewModel: DiaryViewModel(diary: DiaryViewModel.mock)))
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
    
    
    private func daysInMonth(date: Date) -> [(Int, Int)] {
        let calendar = Calendar.current
        let monthRange = calendar.range(of: .day, in: .month, for: date)!
        let firstDayOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: date))!
        var firstWeekdayOfMonth = calendar.component(.weekday, from: firstDayOfMonth)
        
        firstWeekdayOfMonth -= 1
        var days: [(Int, Int)] = Array(1...monthRange.count).map { ($0, UUID().hashValue) }
        for _ in 0..<(firstWeekdayOfMonth % 7) {
            days.insert((0, UUID().hashValue), at: 0)
        }
        print("\(days)")
        return days
    }
}

#Preview {
    CalendarView(viewModel: CalendarViewModel())
}
