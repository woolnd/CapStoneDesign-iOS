
import SwiftUI

struct CalendarDateView: View {
    
    @ObservedObject var viewModel: CalendarViewModel
    @State var date: Int
    @Binding var currentDate: Date
    
    
    var body: some View {
        VStack{
            if(date == 0){
                Text("")
            }
            else{
                HStack{
                    ZStack{
                        Text("\(date)")
                            .font(.custom("777Balsamtint", size: 15))
                            .foregroundColor(isToday(date) ? Color("Week_Orange"): Color("Week_LightGray"))
                        if(isToday(date)){
                            Image("today")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30)
                        }else{
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 30)
                        }
                    }
                    Spacer()
                }
                
                HStack{
                    Spacer()
                    if isMatchingDate(date) {
                        Image("\(emotionForDate(date)!)")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                        
                    }else{
                        Rectangle()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.clear)
                    }
                    
                    Spacer()
                }
                .offset(y: -10.0)
            }
            
        }
    }
    
    private func isMatchingDate(_ date: Int) -> Bool {
        let dateString = "\(formattedYear(date: currentDate))-\(formattedMonth(date: currentDate))-\(String(format: "%02d", date))"
        return viewModel.diary.contains { $0.date == dateString }
    }
    
    private func emotionForDate(_ date: Int) -> String? {
        let dateString = "\(formattedYear(date: currentDate))-\(formattedMonth(date: currentDate))-\(String(format: "%02d", date))"
        if let diaryEntry = viewModel.diary.first(where: { $0.date == dateString }) {
            return diaryEntry.emotion
        }
        return nil
    }
    
    private func formattedDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
    
    private func formattedYear(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter.string(from: date)
    }
    
    private func formattedMonth(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM"
        return formatter.string(from: date)
    }
    
    private func isToday(_ date: Int) -> Bool {
            let calendar = Calendar.current
            let currentDay = calendar.component(.day, from: currentDate)
            let currentMonth = calendar.component(.month, from: currentDate)
            let currentYear = calendar.component(.year, from: currentDate)
            
            return currentYear == calendar.component(.year, from: Date()) &&
                   currentMonth == calendar.component(.month, from: Date()) &&
                   currentDay == date
        }
}

#Preview {
    CalendarDateView(viewModel: CalendarViewModel(diary: CalendarViewModel.mock), date: 17, currentDate: .constant(Date()))
}
