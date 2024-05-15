//
//  CalendarViewModel.swift
//  CapStoneDesign
//
//  Created by Wodnd on 4/8/24.
//

import Foundation

final class CalendarViewModel: ObservableObject{
    
    @Published var diary: [CalendarModel]
    
    struct CalendarModel: Hashable, Identifiable{
        var id: UUID = UUID()
        var diaryId: Int
        var date: String
        var emotion: String

    }
    
    init(diary: [CalendarModel]) {
        self.diary = diary
    }
    
    func updateDiary(with newDiary: [CalendarModel]) {
            self.diary = newDiary
    }
    
}

extension CalendarViewModel{
    static let mock: [CalendarModel] = [
        CalendarModel(diaryId: 1, date: "2024-03-04", emotion: "PLEASURE"),
        CalendarModel(diaryId: 2, date: "2024-04-04", emotion: "PLEASURE"),
        CalendarModel(diaryId: 3, date: "2024-04-01", emotion: "PLEASURE")
    ]
}

