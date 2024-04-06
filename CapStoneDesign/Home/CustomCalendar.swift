//
//  CustomCalendar.swift
//  CapStoneDesign
//
//  Created by Wodnd on 4/4/24.
//

import SwiftUI

struct CustomCalendar: View {
    @Binding var currentDate: Date
    
    //Month update on arrow button click
    @State var currentMonth: Int = 0
    
    var body: some View {
        VStack(spacing:20){
            
            //Days
            let days: [String] = ["일", "월", "화", "수", "목", "금", "토"]
            HStack(spacing:20){

                Button(action: {
                    currentMonth -= 1
                }, label: {
                   Image(systemName: "chevron.left")
                        .font(.title2)
                })
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 10){
                    Text(extraDate()[0])
                        .font(.system(size: 20, weight: .semibold))
                    Text(extraDate()[1])
                        .font(.system(size: 30, weight: .bold))
                }
                
                Spacer()
                
                
                Button(action: {
                    currentMonth += 1
                }, label: {
                   Image(systemName: "chevron.right")
                        .font(.title2)
                })
            }
            .padding(.horizontal)
            
            //Day View
            HStack{
                ForEach(days, id: \.self){ day in
                    Text(day)
                        .font(.callout)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                }
            }
            
            //Dates
            let columns = Array(repeating: GridItem(.flexible()), count: 7)
            
            LazyVGrid(columns: columns, spacing: 40){
                ForEach(extraDate()){ value in
                    CardView(value: value)
                        .background(
                            Rectangle()
                                .fill(Color.pink.opacity(isSameDay(date1: value.date, date2: currentDate) ? 1 : 0))
                                .padding(0)
                                .cornerRadius(10)
                        )
                        .frame(width: 40, height: 40)
                        .onTapGesture {
                            currentDate = value.date
                        }
                }
            }
        }
        .onChange(of: currentMonth) { newValue in
            //updating Month
            currentDate = getCurrentMonth()
        }
    }
        
    
    @ViewBuilder
    func CardView(value: DateValue) -> some View{
        VStack{
            if value.day != -1{
                if let diary = diarys.first(where: { diary in
                    return isSameDay(date1: diary.diaryDate, date2: value.date)
                }){
                    Text("\(value.day)")
                        .font(.title3.bold())
                        .foregroundColor(isSameDay(date1: diary.diaryDate, date2: currentDate) ? .white : .primary)
                        .frame(maxWidth: .infinity)
                    
                    Spacer()
                    Image(systemName: "\(diary.emotion)")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                        .background(
                            Rectangle()
                                .fill(Color.pink.opacity(isSameDay(date1: value.date, date2: currentDate) ? 1 : 0))
                                .padding(0)
                                .cornerRadius(10)
                        )
                        .onTapGesture {
                            currentDate = value.date
                        }
                    
                }
                else{
                    Text("\(value.day)")
                        .font(.title3.bold())
                        .foregroundColor(isSameDay(date1: value.date, date2: currentDate) ? .white : .primary)
                        .frame(maxWidth: .infinity)
                
                    Spacer()
                    Image("")
                        .frame(width: 30, height: 30)
                        .background(
                            Rectangle()
                                .fill(Color.pink.opacity(isSameDay(date1: value.date, date2: currentDate) ? 1 : 0))
                                .padding(0)
                                .cornerRadius(10)
                        )
                        .onTapGesture {
                            currentDate = value.date
                        }
                }
            }
        }
        .padding(.vertical, 9)
    }
    
    //checking date
    func isSameDay(date1: Date, date2: Date) -> Bool{
        let calendar = Calendar.current
        
        return calendar.isDate(date1, inSameDayAs: date2)
    }
    //extrating year and month for display
    func extraDate() -> [String]{
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR") // 한국어 로케일 설정
        formatter.dateFormat = "YYYY MMMM"
        
        let date = formatter.string(from: currentDate)
        return date.components(separatedBy: " ")
    }
    
    func getCurrentMonth() -> Date{
        let calendar = Calendar.current
        
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth,to: Date()) else {
            return Date()
        }
        return currentMonth
    }
    func extraDate() -> [DateValue]{
        let calendar = Calendar.current
        
        let currentMonth = getCurrentMonth()
        var days = currentMonth.getAllDates().compactMap { date -> DateValue in
            
            let day = calendar.component(.day, from: date)
            return DateValue(day: day, date: date)
        }
        
        //adding offset days to get exact week day
        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date())
        
        for _ in 0..<firstWeekday - 1{
            days.insert(DateValue(day: -1, date: Date()), at: 0)
        }
        return days
    }

}

#Preview {
    TabBarView()
}

//Extending Date to get Current Month Date
extension Date{
    func getAllDates() -> [Date]{
        let calendar = Calendar.current
        
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year, .month], from: self))!
        
        let range = calendar.range(of: .day, in: .month, for: startDate)!
        
        return range.compactMap { day -> Date in
            return calendar.date(byAdding: .day, value: day - 1, to: startDate)!
        }
    }
}
