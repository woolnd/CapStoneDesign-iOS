//
//  AnnouncementViewModel.swift
//  CapStoneDesign
//
//  Created by Wodnd on 4/30/24.
//

import Foundation

final class AnnouncementViewModel: ObservableObject{
    @Published var announcements: [announcement]
    
    struct announcement: Hashable, Identifiable{
        var id: UUID = UUID()
        var title: String
        var content: String
        var isExpanded: Bool
    }
    
    init(announcements: [announcement]) {
        self.announcements = announcements
    }
}

extension AnnouncementViewModel{
    static var list: [announcement] = [
        announcement(title: "공지사항 1", content: "공지사항 예시입니다 1", isExpanded: false),
        announcement(title: "공지사항 2", content: "공지사항 예시입니다 2", isExpanded: false),
        announcement(title: "공지사항 3", content: "공지사항 예시입니다 3", isExpanded: false),
        announcement(title: "공지사항 4", content: "공지사항 예시입니다 4", isExpanded: false),
        announcement(title: "공지사항 5", content: "공지사항 예시입니다 5", isExpanded: false)
    ]
}
