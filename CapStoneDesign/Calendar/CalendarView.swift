//
//  test.swift
//  CapStoneDesign
//
//  Created by Wodnd on 4/11/24.
//

import SwiftUI

struct CalendarView: View {
    
    @State var isPresented: Bool = false
    @StateObject var viewModel = CalendarViewModel(diary: CalendarViewModel.mock)
    @State var currentDate: Date = Date()
    @State var selectionDate = 0
    
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
        GeometryReader { geometry in
            NavigationView{
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
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                    
                    
                    ZStack{
                        Image("calendar_background")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(EdgeInsets(top: -110, leading: 0, bottom: 0, trailing: 0))
                        
                        VStack{
                            LazyVGrid(columns: layout){
                                ForEach(week, id: \.self){ week in
                                    Text("\(week)")
                                        .font(.custom("KyoboHandwriting2021sjy",size: 18))
                                        .frame(width: 50)
                                        .foregroundColor(week == "SUN" || week == "SAT" ? Color("Orange") : Color("LightGray"))
                                    
                                }
                            }
                            .padding(EdgeInsets(top: -5, leading: 10, bottom: 0, trailing: 10))
                            
                            LazyVGrid(columns: layout){
                                ForEach(daysInMonth(date: currentDate), id: \.self) { day in
                                    NavigationLink(destination: isMatchingDate(day) ? AnyView(CalendarDetailView()) : AnyView(EmotionInputView(date: day, currentDate: $currentDate))) {
                                        CalendarDateView(date: day, currentDate: $currentDate)
                                    }
//                                    NavigationLink(destination: isMatchingDate(day) ? AnyView(CalendarDetailView()) : AnyView(EmotionInputView(date: day, currentDate: $currentDate))) {
//                                        CalendarDateView(date: day, currentDate: $currentDate)
//                                    }
                                }
                            }
                            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                            Spacer()
                        }
                    }
                    
                    Spacer()
                    
//                    HStack{
//                        Spacer()
//
//                        Button(action: {
//
//                        }, label: {
//                            Image("diary_btn")
//                                .shadow(radius: 1)
//                        })
//                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 30, trailing: 30))
//                    }
//
//                    Spacer()
                }
                .background(
                    Image("initial_background")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .ignoresSafeArea()
                )
            }
            .frame(width: geometry.size.width * 1)
            .sheet(isPresented: $isPresented, content: {
                CalendarIntroView()
            })
        }
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
    
    private func isMatchingDate(_ date: Int) -> Bool {
        let dateString = "\(formattedyear(date: currentDate))-\(formattedMonth(date: currentDate))-\(String(format: "%02d", date))"
        return viewModel.diary.contains { $0.day == dateString }
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
    CalendarView()
}
