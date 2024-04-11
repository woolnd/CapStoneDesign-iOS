//
//   CalendarView.swift
//  CapStoneDesign
//
//  Created by Wodnd on 4/3/24.
//

import SwiftUI

struct CalendartestView: View {
    
    @State var isPresented: Bool = false
    @StateObject var viewModel = CalendarViewModel(diary: CalendarViewModel.mock)
    @State var currentDate: Date = Date()

    let week: [String] = ["일", "월", "화", "수", "목", "금", "토"]
    
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
        NavigationView{
            VStack(spacing:15){
                HStack{
                    Button(action: {
                        isPresented = true
                    }, label: {
                        Image(systemName: "questionmark.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                    })
                    Spacer()

                    Text("Logo")
                        .font(.system(size: 20, weight: .light))
                    Spacer()
                        .frame(width: 160)
                }
                
                HStack{
                    
                    Button(action: {
                        self.currentDate = Calendar.current.date(byAdding: .month, value: -1, to: self.currentDate)!
                    }, label: {
                        Image(systemName: "arrowtriangle.backward")
                    })
                    
                    Spacer()
                    
                    Text("\(formattedYear(date: currentDate))")
                    
                    Spacer()
                    
                    Button(action: {
                        self.currentDate = Calendar.current.date(byAdding: .month, value: +1, to: self.currentDate)!
                    }, label: {
                        Image(systemName: "arrowtriangle.right")
                    })
                }
                
                LazyVGrid(columns: layout){
                    Section {
                        ForEach(week, id: \.self){ week in
                            Text("\(week)")
                        }
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                        
                        ForEach(daysInMonth(date: currentDate), id: \.self) { day in
                            NavigationLink(destination: isMatchingDate(day) ? AnyView(CalendarDetailView()) : AnyView(EmotionInputView())) {
                                CalendarDateView(date: day, currentDate: $currentDate)
                            }
                        }
                        
                    } header: {}

                }
                .padding()
                
                Spacer()
            }
        }
        .sheet(isPresented: $isPresented, content: {
            CalendarIntroView()
        })
    }
}

extension CalendartestView{
    private func formattedYear(date: Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: date)
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
    CalendartestView()
}

