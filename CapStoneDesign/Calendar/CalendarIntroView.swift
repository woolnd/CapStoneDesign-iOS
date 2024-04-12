//
//  CalendarIntroView.swift
//  CapStoneDesign
//
//  Created by Wodnd on 4/9/24.
//

import SwiftUI

struct CalendarIntroView: View {
    var body: some View {
        VStack{
            Text("hello")
            Spacer()
            Text("hello")
        }
        .background(
            Image("initial_background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
        )
    }
}

#Preview {
    CalendarIntroView()
}
