//
//   CalendarView.swift
//  CapStoneDesign
//
//  Created by Wodnd on 4/3/24.
//

import SwiftUI

struct CalendarView: View {
    @State var currentDate: Date = Date()
    
    var body: some View {
        ZStack {
//            // 배경 이미지
//            Image("back")
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//                .edgesIgnoringSafeArea(.all)
            
            // 스크롤뷰
//            ScrollView(.vertical, showsIndicators: false) {
//
//            }
            VStack{
                CustomCalendar(currentDate: $currentDate)
                Spacer()
            }
        }
    }
}

#Preview {
    CalendarView()
}

