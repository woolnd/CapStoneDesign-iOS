//
//  InitialViewModle.swift
//  CapStoneDesign
//
//  Created by Wodnd on 4/11/24.
//

import Foundation

final class InitialViewModel: ObservableObject{
    @Published var contents: [initialContent]
    
    
    struct initialContent: Hashable, Identifiable{
        var id: UUID = UUID()
        var title: String
        var content: String
    }
    
    init(contents: [initialContent]) {
        self.contents = contents
    }
}

extension InitialViewModel{
    static let mock: [initialContent] = [
        initialContent(title: "감정일기란?", content: "감정일기는 하루 동안 느낀 감정들을 솔직하게 표현하는 활동이에요.\n\n오늘의 일상을 기록하는 것도 좋지만, 감정을 기록하며 내면의 나에게 한발짝 다가갈 수 있어요. 내 감정에 주의를 기울이고, 이해하고 받아들이는 과정은 자기 사랑과 자존감을 높이는데 도움을 줄 거예요.\n오늘의 감정을 되돌아보며, 어떤 감정을 느꼈는지, 그 감정이 어떤 상황에서 발생했는지를 기록해봐요.\n\n자신의 감정에 솔직해지며, 내면의 변화와 성장을 경험하게 될거예요!"),
        initialContent(title: "캘린더 사용법!", content: "우리의 일상을 소중히 기록하고 싶다면, 오늘의 나를 기록하기 위해 캘린더의 날짜를 눌러봐요.\n\n일기를 시작하기 전  답장 받고 싶은 타입을 선택하고 솔직한 나의 감정을 선택할 수 있어요. 때론 친구처럼, 때론 (엄마처럼) AI 밍글이가 일기를 보고 가장 따뜻한 답장을 해 줄 거예요.\n\n일상의 소중한 순간들을 밍글이와 함께 기록하고, 감정을 나누며 소통의 즐거움을 경험해봐요!"),
        initialContent(title: "감정추이란?", content: "일기를 꾸준히 작성한 후 감정을 시각적으로 파악할 수 있게 해줘요.\n\n월별로 어떤 감정을 주로 느꼈는지를 알 수 있어요. 시간이 지남에 따라 감정 변화를 명확하게 알게되고 자기 관리 능력을 향상시킬 수 있어요.\n\n감정추이를 보고 그 시기의 나를 되돌아봐요!"),
        initialContent(title: "나는 기록 도우미 밍글이", content: "안녕~! 나는 당신의 감정을 기록해줄 밍글이에요\n소심하구 밍기적 거리는걸 좋아해서 밍글이라고 불려요! \n여러분의 귀여운 기록 도우미로 감정을 분석해 주고 있어요! \n\n기록을 시작해 볼까요?")
    ]
}


