//
//  EmotionViewModel.swift
//  CapStoneDesign
//
//  Created by Wodnd on 4/12/24.
//

import Foundation

final class EmotionViewModel: Observable{
    @Published var emotions: [emotion]
    @Published var weathers: [weather]
    
    struct emotion: Hashable, Identifiable{
        var id: UUID = UUID()
        var name: String
        var imageName: String
        var isSelected: Bool
    }
    
    struct weather: Hashable, Identifiable{
        var id: UUID = UUID()
        var imageName: String
        var isSelected: Bool
    }
    
    init(emotions: [emotion], weathers: [weather]) {
        self.emotions = emotions
        self.weathers = weathers
    }
}

extension EmotionViewModel{
    static var list : [emotion] = [
    
        emotion(name: "기쁨", imageName: "pleasure", isSelected: false),
        emotion(name: "공포", imageName: "fear", isSelected: false),
        emotion(name: "평온", imageName: "peace", isSelected: false),
        emotion(name: "분노", imageName: "angry", isSelected: false),
        emotion(name: "설렘", imageName: "flutter", isSelected: false),
        emotion(name: "슬픔", imageName: "sadness", isSelected: false),
        emotion(name: "감동", imageName: "moved", isSelected: false),
        emotion(name: "걱정", imageName: "worry", isSelected: false),
        emotion(name: "자신감", imageName: "confidence", isSelected: false),
        emotion(name: "무기력", imageName: "lethargy", isSelected: false)
    ]
    
    static var weatherList: [weather] = [
        weather(imageName: "cloud", isSelected: false),
        weather(imageName: "sunny", isSelected: false),
        weather(imageName: "rain", isSelected: false)
    ]
}
