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
        ScrollView(.vertical, showsIndicators: false){
            VStack(spacing: 20){
                CustomCalendar(currentDate: $currentDate)
            }
        }
    }
}

#Preview {
    CalendarView()
}
