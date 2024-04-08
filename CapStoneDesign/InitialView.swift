//
//  InitialView.swift
//  CapStoneDesign
//
//  Created by Wodnd on 4/7/24.
//

import SwiftUI

struct InitialView: View {
    var body: some View {
        Spacer()
        
        Text("App Name")
            .font(.system(size: 40, weight: .bold))
        
        Spacer()
        
        VStack{
            Text("Naver Login")
            Text("Google Login")
        }
        
        Spacer()
            .frame(height: 40)
    }
}

#Preview {
    InitialView()
}
