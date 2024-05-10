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
    
        emotion(name: "기쁨", imageName: "PLEASURE", isSelected: false),
        emotion(name: "우울", imageName: "SADNESS", isSelected: false),
        emotion(name: "평온", imageName: "PEACE", isSelected: false),
        emotion(name: "분노", imageName: "ANGER", isSelected: false),
        emotion(name: "설렘", imageName: "FLUTTER", isSelected: false),
        emotion(name: "공포", imageName: "FEAR", isSelected: false),
        emotion(name: "감동", imageName: "MOVED", isSelected: false),
        emotion(name: "걱정", imageName: "WORRY", isSelected: false),
        emotion(name: "자신감", imageName: "COFIDENCE", isSelected: false),
        emotion(name: "무기력", imageName: "LETHARGY", isSelected: false)
    ]
    
    static var weatherList: [weather] = [
        weather(imageName: "SUNNY", isSelected: false),
        weather(imageName: "CLOUDY", isSelected: false),
        weather(imageName: "RAINY", isSelected: false)
    ]
}
