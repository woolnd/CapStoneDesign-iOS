//
//  DiaryInputView.swift
//  CapStoneDesign
//
//  Created by Wodnd on 4/13/24.
//

import SwiftUI

struct DiaryInputView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var currentDate: String
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView{
                VStack{
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        
                        HStack{
                            
                            Image(systemName: "chevron.left")
                                .resizable()// 화살표 Image
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                            Spacer()
                            
                            Text("MoodMingle")
                                .font(.custom("KyoboHandwriting2021sjy", size: 25))
                            
                            Spacer()
                            
                            Button(action: {
                                
                            }, label: {
                                Image("introduce")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 70,height: 70)
                                    .padding(EdgeInsets(top: 0, leading: -50, bottom: 0, trailing: 0))
                            })
                            
                        }
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    })
                    
                    Text(currentDate)
                    
                    Spacer()
                }
                .background(
                    Image("initial_background")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .ignoresSafeArea()
                )
            }
            .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    DiaryInputView(currentDate: "2024-04-18")
}
