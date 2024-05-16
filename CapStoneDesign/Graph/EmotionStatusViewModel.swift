//
//  EmotionStatusViewModel.swift
//  CapStoneDesign
//
//  Created by Wodnd on 5/17/24.
//

import Foundation
final class EmotionStatusViewModel: ObservableObject{
    
    @Published var emotion: Emotions
    
    struct Emotions: Hashable, Identifiable{
        var id: UUID = UUID()
        var fear: Int
        var moved: Int
        var lethargy: Int
        var flutter: Int
        var peace: Int
        var pleasure: Int
        var confidence: Int
        var worry: Int
        var anger: Int
        var sadness: Int

    }
    
    init(emotion: Emotions) {
        self.emotion = emotion
    }
    
    func updateEmotion(with newEmotion: Emotions) {
            self.emotion = newEmotion
    }
    
}

extension EmotionStatusViewModel{
    static let mock: Emotions = Emotions(fear: 3, moved: 7, lethargy: 1, flutter: 8, peace: 9, pleasure: 10, confidence: 6, worry: 2, anger: 4, sadness: 5)
}
