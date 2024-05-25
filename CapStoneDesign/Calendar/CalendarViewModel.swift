//
//  CalendarViewModel.swift
//  CapStoneDesign
//
//  Created by Wodnd on 4/8/24.
//

import Foundation

final class CalendarViewModel: ObservableObject {
    @Published var diary: [CalendarModel] = []
    
    struct CalendarModel: Hashable, Identifiable {
        var id: UUID = UUID()
        var diaryId: Int
        var date: String
        var emotion: String
    }
    
    let service = Service()
    
    init() {
        loadDiaryData(for: Date())
    }
    
    func updateDiary(with newDiary: [CalendarModel]) {
        self.diary = newDiary
    }
    
    func loadDiaryData(for date: Date) {
        let formattedDate = formattedApi(date: date)
        service.DiaryRequest(dtos: DiaryRequest(dto: MonthDto(date: formattedDate))) { result in
            switch result {
            case .success(let response):
                let diaryModels = response.map { CalendarModel(diaryId: $0.diaryId, date: $0.date, emotion: $0.emotion) }
                DispatchQueue.main.async {
                    self.updateDiary(with: diaryModels)
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    private func formattedApi(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM"
        return formatter.string(from: date)
    }
}

extension CalendarViewModel {
    static let mock: [CalendarModel] = [
        CalendarModel(diaryId: 1, date: "2024-03-04", emotion: "PLEASURE"),
        CalendarModel(diaryId: 2, date: "2024-04-04", emotion: "PLEASURE"),
        CalendarModel(diaryId: 3, date: "2024-04-01", emotion: "PLEASURE")
    ]
}
