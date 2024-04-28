//
//  MyPageView.swift
//  CapStoneDesign
//
//  Created by Wodnd on 4/10/24.
//

import SwiftUI

struct MyPageView: View {
    
    var body: some View {
        NavigationStack{
            ZStack{
                Image("initial_background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                
                VStack{
                    HStack{
                        
                        Spacer()
                        
                        Text("MoodMingle")
                            .font(.custom("KyoboHandwriting2021sjy", size: 25))
                            .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
                        
                        Spacer()
                    }
                    
                    Spacer()
                    
                    Image("mypage_main")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                    
                    Spacer()
                    
                }
                
            }
        }
        .toolbar(.hidden)
        .navigationBarBackButtonHidden(true)
        
    }
}

#Preview {
    MyPageView()
}
