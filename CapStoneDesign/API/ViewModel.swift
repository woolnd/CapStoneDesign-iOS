//
//  ViewModel.swift
//  CapStoneDesign
//
//  Created by Wodnd on 5/6/24.
//

import Foundation

struct LetterDto: Codable{
    var dto: Dto
    var image: String
}

struct Dto: Codable{
    var memberId: Int
    var title: String
    var date: String
    var content: String
    var emotion: String
    var weather: String
    
    private enum CodingKeys: String, CodingKey {
            case memberId = "memberId"
            case title = "title"
            case date = "date"
            case content = "content"
            case emotion = "emotion"
            case weather = "weather"
    }
}

struct DiaryResponse: Codable{
    
}


struct GraphResponse: Codable{
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
    
    private enum CodingKeys: String, CodingKey {
        case fear = "FEAR"
        case moved = "MOVED"
        case lethargy = "LETHARGY"
        case flutter = "FLUTTER"
        case peace = "PEACE"
        case pleasure = "PLEASURE"
        case confidence = "CONFIDENCE"
        case worry = "WORRY"
        case anger = "ANGER"
        case sadness = "SADNESS"
    }
}
