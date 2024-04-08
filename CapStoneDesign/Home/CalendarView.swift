//
//   CalendarView.swift
//  CapStoneDesign
//
//  Created by Wodnd on 4/3/24.
//

import SwiftUI

struct CalendarView: View {
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
            VStack(spacing:20){
                HStack{
                    Image(systemName: "questionmark.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20)
                    Spacer()
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
                        
                        ForEach(daysInMonth(date: currentDate), id: \.self) { day in
                            NavigationLink {
                                CalendarDateView()
                            } label: {
                                if(day == 0){
                                    Text("")
                                }else{
                                    Text("\(day)")
                                }
                            }

                        }
                        
                    } header: {}

                }
                .padding()
                
                Spacer()
            }
        }
    }
}

extension CalendarView{
    private func formattedYear(date: Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
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

