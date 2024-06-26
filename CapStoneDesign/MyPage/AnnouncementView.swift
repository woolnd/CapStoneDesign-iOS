//
//  AnnouncementView.swift
//  CapStoneDesign
//
//  Created by Wodnd on 4/30/24.
//

import SwiftUI

struct AnnouncementView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var vm = AnnouncementViewModel(announcements: AnnouncementViewModel.list)
    
    let layout: [GridItem] = [
        GridItem(.flexible())
    ]
    
    var body: some View {
        GeometryReader{ geo in
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
                                    .frame(width: geo.size.width * 0.04)
                            })
                            .padding(EdgeInsets(top: 0, leading: geo.size.width * 0.05, bottom: 0, trailing: 0))
                            
                            Spacer()
                            
                            Text("MoodMingle")
                                .font(.custom("KyoboHandwriting2021sjy", size: geo.size.width * 0.05))
                            
                            Spacer()
                            
                            Rectangle()
                                .frame(width: geo.size.width * 0.13, height: geo.size.width * 0.18)
                                .foregroundColor(.clear)
                        }
                        
                        LazyVGrid(columns: layout){
                            ForEach(vm.announcements.indices, id: \.self){ index in
                                var announce = vm.announcements[index]
                                DisclosureGroup("\(announce.title)", isExpanded: $vm.announcements[index].isExpanded) {
                                    HStack{
                                        Text("\(announce.content)")
                                            .font(.custom("777Balsamtint", size: 20))
                                            .padding()
                                        Spacer()
                                    }
                                }
                                .onTapGesture {
                                    announce.isExpanded.toggle()
                                }
                                .font(.custom("777Balsamtint", size: 25))
                                .padding()
                            }
                        }
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                        Spacer()
                    }
                    
                }
                .accentColor(Color.black)
            }
            .toolbar(.hidden)
            .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    AnnouncementView()
}
