//
//  InitialViewModle.swift
//  CapStoneDesign
//
//  Created by Wodnd on 4/11/24.
//

import Foundation

final class InitialViewModle: ObservableObject{
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

extension InitialViewModle{
    static let mock: [initialContent] = [
        initialContent(title: "감정일기란?", content: "감정일기 내용"),
        initialContent(title: "캘린더 사용법!", content: "캘린더 사용법 내용"),
        initialContent(title: "감정추이란?", content: "감정추이 내용"),
        initialContent(title: "나는 기록 도우미 밍글이", content: "밍글이 소개")
        
    ]
}


