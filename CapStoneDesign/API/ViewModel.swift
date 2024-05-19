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
    var title: String
    var date: String
    var content: String
    var emotion: String
    var weather: String
    
    private enum CodingKeys: String, CodingKey {
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
    var date: String
    
    private enum CodingKeys: String, CodingKey {
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
    var diaryId: Int
    
    private enum CodingKeys: String, CodingKey {
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
    var imageUrl: String?
    var replyContent: String?
    var type: String?
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


struct JoinResponse: Codable{
    var accessToken: String
    var refreshToken: String
    
    private enum CodingKeys: String, CodingKey {
        case accessToken = "accessToken"
        case refreshToken = "refreshToken"
    }
    
}

struct LoginResponse: Codable{
    var accessToken: String
    var refreshToken: String
    
    private enum CodingKeys: String, CodingKey {
        case accessToken = "accessToken"
        case refreshToken = "refreshToken"
    }
    
}


struct InfoResponse: Codable{
    var name: String
    var email: String
    var imageUrl: String
    
    private enum CodingKeys: String, CodingKey {
        case name = "name"
        case email = "email"
        case imageUrl = "imageUrl"
    }
    
}

struct RefreshResponse: Codable{
    var accessToken: String
    var refreshToken: String
    
    private enum CodingKeys: String, CodingKey {
        case accessToken = "accessToken"
        case refreshToken = "refreshToken"
    }
    
}

struct ErrorResponse: Codable{
    var code: String
    var error: String
    var message: String
    var status: Int
    
    private enum CodingKeys: String, CodingKey {
        case code = "code"
        case error = "error"
        case message = "message"
        case status = "status"
    }
    
}

