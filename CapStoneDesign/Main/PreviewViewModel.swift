//
//  PreviewViewModel.swift
//  CapStoneDesign
//
//  Created by Wodnd on 5/22/24.
//

import Foundation

final class PreviewViewModel: ObservableObject{
    @Published var contents: [previewContent]
    
    
    struct previewContent: Hashable, Identifiable{
        var id: UUID = UUID()
        var title: String
        var content: String
    }
    
    init(contents: [previewContent]) {
        self.contents = contents
    }
}

extension PreviewViewModel{
    static let mock: [previewContent] = [
        previewContent(title: "원하는 날에 감정 일기를\n작성해 보아요", content: "1"),
        previewContent(title: "느꼈던 감정을\n선택해 보아요", content: "2"),
        previewContent(title: "원하는 답변 형식을\n선택해 보아요", content: "3"),
        previewContent(title: "사진과 날씨를 선택하여\n그날을 떠올려 보아요", content: "4"),
        previewContent(title: "작성 완료시\n밍글이가 답변을 해줄 거에요", content: "5"),
        previewContent(title: "밍글이가 정성을 다하여 빠르게 답변을 해줄 거에요", content: "6"),
        previewContent(title: "시각화된 감정그래프로\n나를 되돌아 볼 수 있어요", content: "7"),
        previewContent(title: "나만의 비밀번호로\n일기를 보호해 보아요", content: "8"),
    ]
}


