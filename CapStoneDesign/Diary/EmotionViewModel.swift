//
//  EmotionViewModel.swift
//  CapStoneDesign
//
//  Created by Wodnd on 4/12/24.
//

import Foundation

final class EmotionViewModel: Observable{
    @Published var emotions: [emotion]
    
    struct emotion: Hashable, Identifiable{
        var id: UUID = UUID()
        var name: String
        var imageName: String
    }
    
    init(emotions: [emotion]) {
        self.emotions = emotions
    }
}

extension EmotionViewModel{
    static var list : [emotion] = [
    
        emotion(name: "기쁨", imageName: "pleasure"),
        emotion(name: "평온", imageName: "peace"),
        emotion(name: "설렘", imageName: "flutter"),
        emotion(name: "감동", imageName: "moved"),
        emotion(name: "자신감", imageName: "confidence"),
        emotion(name: "공포", imageName: "fear"),
        emotion(name: "분노", imageName: "angry"),
        emotion(name: "슬픔", imageName: "sadness"),
        emotion(name: "걱정", imageName: "worry"),
        emotion(name: "무기력", imageName: "lethargy")
        
    ]
}
