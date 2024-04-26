//
//  MyPageView.swift
//  CapStoneDesign
//
//  Created by Wodnd on 4/10/24.
//

import SwiftUI

struct MyPageView: View {
    var body: some View {
        ZStack{
            Image("initial_background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
            Text("This is my Page")
        }
    }
}

#Preview {
    MyPageView()
}
