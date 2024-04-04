//
//  Diary.swift
//  CapStoneDesign
//
//  Created by Wodnd on 4/4/24.
//

import SwiftUI

struct Diary: Identifiable{
    var id = UUID().uuidString
    var title: String
    var time: Date = Date()
    
}

struct DiaryMetaDate: Identifiable{
    var id = UUID().uuidString
    var diary: [Diary]
    var diaryDate: Date
    var emotion: String
}

func getSampleDate(offset: Int) -> Date{
    let calendar = Calendar.current
    
    let date = calendar.date(byAdding: .day, value: offset, to: Date())
    
    return date ?? Date()
}

var diarys: [DiaryMetaDate] = [
    DiaryMetaDate(diary: [
        Diary(title: "Talk to wodnd")
    ], diaryDate: getSampleDate(offset: 1), emotion: "sun.max.circle"),
    
    DiaryMetaDate(diary: [
        Diary(title: "Talk to teacher")
    ], diaryDate: getSampleDate(offset: -3), emotion: "moon.circle"),
    
    DiaryMetaDate(diary: [
        Diary(title: "Meeint to teacher")
    ], diaryDate: getSampleDate(offset: -8),  emotion: "cloud.drizzle.circle"),
    
    DiaryMetaDate(diary: [
        Diary(title: "Next Version of SwiftUI")
    ], diaryDate: getSampleDate(offset: 10), emotion: "cloud.sun.rain.circle"),
    
    DiaryMetaDate(diary: [
        Diary(title: "Nothing")
    ], diaryDate: getSampleDate(offset: -22), emotion: "hurricane.circle"),
    
    DiaryMetaDate(diary: [
        Diary(title: "My puppy is very cute")
    ], diaryDate: getSampleDate(offset: 15), emotion: "snowflake.circle"),


]
