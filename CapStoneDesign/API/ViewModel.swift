//
//  ViewModel.swift
//  CapStoneDesign
//
//  Created by Wodnd on 5/6/24.
//

import Foundation

struct DiaryRequest: Codable{
    var dto: Dto
    var image: Data
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
