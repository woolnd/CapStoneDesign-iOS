//
//  EmotionalStatusView.swift
//  CapStoneDesign
//
//  Created by Wodnd on 4/10/24.
//

import SwiftUI
import Charts

struct Case2 {
    let date: Int
    let value: Int
    
    static var dummy = [
        (
            name: "김씨",
            data: [
                Case2(date: 1, value: 1),
                Case2(date: 2, value: 10),
                Case2(date: 3, value: 100),
                Case2(date: 4, value: 50),
                Case2(date: 5, value: 120)
            ]
        ),
        (
            name: "이씨",
            data: [
                Case2(date: 1, value: 3),
                Case2(date: 2, value: 30),
                Case2(date: 3, value: 300),
                Case2(date: 4, value: 30),
                Case2(date: 5, value: 1300)
            ]
        )
    ]
}

struct EmotionalStatusView: View {
    
    let case2 = Case2.dummy
    
    var body: some View {
        ZStack {
            Image("initial_background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
            Chart(case2, id: \.name) { element in
                ForEach(element.data, id: \.date) {
                    LineMark(
                        x: .value("date", $0.date),
                        y: .value("value", $0.value)
                    )
                }
                .foregroundStyle(by: .value("name", element.name))
            }
            .background(
                Image("initial_background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
            )
        }
    }
}


#Preview {
    EmotionalStatusView()
}
