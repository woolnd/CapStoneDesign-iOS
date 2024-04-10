import SwiftUI

struct CalendarDateView: View {
    
    @StateObject var viewModel = CalendarViewModel(diary: CalendarViewModel.mock)
    @State var date: Int
    @Binding var currentDate: Date
    
    var body: some View {
        VStack(spacing:10){
            if(date == 0){
                Text("")
            }
            else{
                Text("\(date)")
                    .font(.system(size: 20))
                if isMatchingDate(date) {
                    Image(systemName: "\(emotionForDate(date)!)")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40)
                }else{
                    Image("")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40)
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
}

#Preview {
    CalendarDateView(date: 1, currentDate: .constant(Date()))
}

