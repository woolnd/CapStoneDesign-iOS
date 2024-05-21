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
        announcement(title: "인사드립니다!", content: "안녕하세요, MoodMingle 개발자 팀 CHMOD-777입니다.\n\n현재 베타 테스트 버전을 배포하여 사용자들을 대상으로 설문조사를 받고 있습니다.\n\n설문 조사지는 현재 주변 학부생들을 대상으로 공유했으며, 다른 사용자들도 참여할 수 있고 각종 참여 이벤트도 진행하니 원하시는 분들은 wodnd0418@gmail.com으로 연락해주시면 감사하겠습니다.🙇\n\n편안한 하루 되시고, 이용해주셔서 감사합니다.🍀", isExpanded: false),
    ]
}
