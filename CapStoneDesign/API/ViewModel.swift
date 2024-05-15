//
//  ViewModel.swift
//  CapStoneDesign
//
//  Created by Wodnd on 5/6/24.
//

import Foundation

struct DiaryDto: Codable{
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

struct DiaryRequest: Codable{
    var dto: MonthDto
}

struct MonthDto: Codable{
    var memberId: Int
    var date: String
    
    private enum CodingKeys: String, CodingKey {
        case memberId = "memberId"
        case date = "date"
    }
}

struct DiaryResponse: Codable{
    var diaryId: Int
    var date: String
    var emotion: String
}


struct DiaryDetailRequest: Codable{
    var dto: Diary
}

struct Diary: Codable{
    var memberId: Int
    var diaryId: Int
    
    private enum CodingKeys: String, CodingKey {
        case memberId = "memberId"
        case diaryId = "diaryId"
    }
}

struct DiaryDetailReponse: Codable{
    var diaryId: Int
    var title: String
    var content: String
    var date: String
    var emotion: String
    var weather: String
    var imageUrl: String
    var replyContent: String
    var type: String
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
