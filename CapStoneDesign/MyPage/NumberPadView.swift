//
//  NumberPadView.swift
//  CapStoneDesign
//
//  Created by Wodnd on 5/1/24.
//

import SwiftUI

struct NumberPadView: View {
    var body: some View {
        VStack{
            Image("initial_background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
        }
    }
}

#Preview {
    NumberPadView()
}
