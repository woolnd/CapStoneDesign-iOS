//
//  AccountManagementView.swift
//  CapStoneDesign
//
//  Created by Wodnd on 4/30/24.
//

import SwiftUI

struct AccountManagementView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var appleTokenChk: String = (UserDefaults.standard.string(forKey: "AppleToken") ?? "")
    
    var body: some View {
        NavigationStack{
            ZStack{
                Image("initial_background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                
                VStack{
                    HStack{
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }, label: {
                            
                            Image(systemName: "chevron.left")
                                .resizable()// 화살표 Image
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                                .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 0))
                            
                        })
                        Spacer()
                        
                        Text("MoodMingle")
                            .font(.custom("KyoboHandwriting2021sjy", size: 25))
                            .padding(EdgeInsets(top: 0, leading: -50, bottom: 0, trailing: 0))
                        
                        Spacer()
                    }
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                    
                    Spacer()
                }
                
                
                Text("\(appleTokenChk)")
            }
            .accentColor(Color.black)
        }
        .toolbar(.hidden)
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    AccountManagementView()
}
