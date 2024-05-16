//
//  DiaryResponseView.swift
//  CapStoneDesign
//
//  Created by Wodnd on 5/16/24.
//

import SwiftUI

struct DiaryResponseView: View {
    
    @State var responseType: String
    @State var content: String
    var body: some View {
        GeometryReader{ geo in
            ZStack{
                Image("initial_background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                
                Image("\(responseType)_background")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geo.size.width * 0.95)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: geo.size.width * 0.03))
                VStack{
                    ScrollView{
                        Text("\(content)")
                            .font(.custom("777Balsamtint", size: geo.size.width * 0.06))
                    }
                    .frame(width: geo.size.width * 0.8, height: geo.size.width * 0.9)
                    
                }
            }
        }
    }
}

#Preview {
    DiaryResponseView(responseType: "LETTER", content: "답변 테스트 입니다.")
}
