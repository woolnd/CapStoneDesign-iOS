//
//  DiaryViewModel.swift
//  CapStoneDesign
//
//  Created by Wodnd on 5/15/24.
//

import Foundation

final class DiaryViewModel: ObservableObject{
    
    @Published var diary: DiaryModel
    
    struct DiaryModel: Hashable, Identifiable{
        var id: UUID = UUID()
        var diaryId: Int
        var title: String
        var content: String
        var date:  String
        var emotion: String
        var weather: String
        var imageUrl: String
        var replyContent: String
        var type: String

    }
    
    init(diary: DiaryModel) {
        self.diary = diary
    }
    
    func updateDiary(with newDiary: DiaryModel) {
            self.diary = newDiary
    }
    
}

extension DiaryViewModel{
    static let mock: DiaryModel = DiaryModel(diaryId: 1, title: "테스트 제목", content: "테스트 내용입니다", date: "2024-04-18", emotion: "PLEASURE", weather: "SUNNY", imageUrl: "", replyContent: "", type: "LETTER")
}
