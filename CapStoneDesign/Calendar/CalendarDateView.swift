import SwiftUI

struct CalendarDateView: View {
    
    @ObservedObject var viewModel: CalendarViewModel
    @State var date: Int
    @Binding var currentDate: Date
    
    var body: some View {
        GeometryReader{ geo in
            VStack{
                if(date == 0){
                    Text("")
                } else {
                    HStack{
                        ZStack{
                            Text("\(date)")
                                .font(.custom("777Balsamtint", size: 15))
                                .foregroundColor(isToday(date) ? Color("Week_Orange") : Color("Week_LightGray"))
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
                        } else {
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
        let today = Date()
        let currentDay = calendar.component(.day, from: today)
        let currentMonth = calendar.component(.month, from: today)
        let currentYear = calendar.component(.year, from: today)
        
        return currentYear == calendar.component(.year, from: currentDate) &&
               currentMonth == calendar.component(.month, from: currentDate) &&
               currentDay == date
    }
}

#Preview {
    CalendarDateView(viewModel: CalendarViewModel(), date: 20, currentDate: .constant(Date()))
}

