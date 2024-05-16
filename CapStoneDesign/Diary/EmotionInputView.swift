//
//  EmotionInputVIew.swift
//  CapStoneDesign
//
//  Created by Wodnd on 4/8/24.
//

import SwiftUI

struct EmotionInputView: View {
    @State var date: Int
    @Binding var currentDate: Date
    @State private var choiceDate: String = ""
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var vm = EmotionViewModel(emotions: EmotionViewModel.list, weathers: EmotionViewModel.weatherList)
    @State private var selectedEmotionIndex: Int?
    
    let layout: [GridItem] = [
        GridItem(.flexible(), spacing: -40),
        GridItem(.flexible(), spacing: -40)
    ]
    
    var body: some View {
        GeometryReader{ geo in
            NavigationStack{
                ZStack{
                    Image("initial_background")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .ignoresSafeArea()
                    
                    VStack {
                        
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
                        
                        
                        Text("감성을 선택해주세요!")
                            .font(.custom("777Balsamtint", size: geo.size.width * 0.1))
                        
                        HStack{
                            
                            ScrollView{
                                LazyVGrid(columns: layout){
                                    ForEach(vm.emotions.indices, id: \.self) { index in
                                        let emotion = vm.emotions[index]
                                        EmotionDetailView(emotion: emotion)
                                            .opacity(selectedEmotionIndex != nil && selectedEmotionIndex != index ? 0.5 : 1.0)
                                            .onTapGesture {
                                                if let prevSelectedIndex = selectedEmotionIndex {
                                                    vm.emotions[prevSelectedIndex].isSelected = false
                                                }
                                                vm.emotions[index].isSelected.toggle()
                                                selectedEmotionIndex = index
                                            }
                                    }
                                }
                            }
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 70, trailing: geo.size.width * 0.04))
                        }
                        
                        Spacer()
                    }
                    .onAppear {
                        choiceDate = formattedDate
                    }
                    
                    VStack {
                        Spacer()
                        
                        if selectedEmotionIndex != nil {
                            NavigationLink {
                                ResponseView(currentDate: formattedDate, currentEmotion: selectedEmotionIndex!)
                            } label: {
                                Image("emotion_btn_on")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geo.size.width * 0.9)
                            }

                        }else{
                            Image("emotion_btn_off")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geo.size.width * 0.9)
                        }
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: geo.size.width * 0.04))
                    
                }
                .accentColor(Color.black)
            }
            .toolbar(.hidden)
            .navigationBarBackButtonHidden()
        }
    }
    
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM"
        let day: String
        if(date < 10){
            day = "0\(date)"
        }
        else{
            day = "\(date)"
        }
    
        return "\(formatter.string(from: currentDate))-\(day)"
    }
}


#Preview {
    EmotionInputView(date: 1, currentDate: .constant(Date()))
}
