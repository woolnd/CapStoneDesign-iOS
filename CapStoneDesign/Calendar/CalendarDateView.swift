import SwiftUI

struct CalendarDateView: View {
    
    @StateObject var viewModel = CalendarViewModel(diary: CalendarViewModel.mock)
    @State var date: Int
    @Binding var currentDate: Date
    
    
    var body: some View {
        VStack{
            if(date == 0){
                Text("")
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: -3, trailing: 20))
            }
            else{
                ZStack{
                    Text("\(date)")
                        .font(.custom("777Balsamtint", size: 15))
                        .foregroundColor(isToday(date) ? Color("Orange"): Color("LightGray"))
                        .frame(width: 20)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 25))
                    if(isToday(date)){
                        Image("today")
                            .padding(EdgeInsets(top: -15, leading: -8, bottom: -11, trailing: 20))
                    }
                }
            
                if isMatchingDate(date) {
                    Image("\(emotionForDate(date)!)")
                        .frame(width: 45, height: 30)
                        .padding(EdgeInsets(top: -1, leading: 0, bottom: 0, trailing: 0))
                    
                }else{
                    Rectangle()
                        .frame(width: 45, height: 30)
                        .foregroundColor(.clear)
                        .padding(EdgeInsets(top: -1, leading: 0, bottom: 0, trailing: 0))
                }
                
            }
        }
    }
    
    private func isMatchingDate(_ date: Int) -> Bool {
        let dateString = "\(formattedYear(date: currentDate))-\(formattedMonth(date: currentDate))-\(String(format: "%02d", date))"
        return viewModel.diary.contains { $0.day == dateString }
    }
    
    private func emotionForDate(_ date: Int) -> String? {
        let dateString = "\(formattedYear(date: currentDate))-\(formattedMonth(date: currentDate))-\(String(format: "%02d", date))"
        if let diaryEntry = viewModel.diary.first(where: { $0.day == dateString }) {
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
            let today = Calendar.current.component(.day, from: Date())
            return today == date
        }
}

#Preview {
    CalendarDateView(date: 1, currentDate: .constant(Date()))
}

