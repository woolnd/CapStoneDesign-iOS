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
        var day: String
        var content: String
        var emotion: String

    }
    
    init(diary: [CalendarModel]) {
        self.diary = diary
    }
}

extension CalendarViewModel{
    static let mock: [CalendarModel] = [
        CalendarModel(day: "2024-03-08", content: "hello", emotion: "moon"),
        CalendarModel(day: "2024-04-04", content: "bye", emotion: "moon.dust"),
        CalendarModel(day: "2024-04-01", content: "hellobye", emotion: "moon.dust")
    ]
}

