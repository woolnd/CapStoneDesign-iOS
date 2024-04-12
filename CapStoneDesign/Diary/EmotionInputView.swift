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
    @State var vm = EmotionViewModel(emotions: EmotionViewModel.list)
    
    let layout: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView{
                VStack {
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
                                .padding(EdgeInsets(top: 0, leading: -30, bottom: 0, trailing: 0))
                            
                            Spacer()
                        }
                        .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
                    })
                    
                    Text("감성을 선택해주세요!")
                        .font(.custom("777Balsamtint", size: 35))
                        .padding(EdgeInsets(top: 40, leading: 0, bottom: 30, trailing: 0))
                
                    ScrollView{
                        LazyVGrid(columns: layout){
                            ForEach(vm.emotions, id: \.self){ emotion in
                                EmotionDetailView(emotion: emotion)
                            }
                        }
                    }
//                    Text("\(date)")
//                    Text("\(currentDate)")
//                    Text("\(formattedDate)")
                    
                    Spacer()
                }
                .background(
                    Image("initial_background")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .ignoresSafeArea()
                )
                .onAppear {
                    choiceDate = formattedDate
                }
                
                
            }
            .frame(width: geometry.size.width * 1)
            .navigationBarBackButtonHidden()
/*            .navigationBarItems(leading: backButton) */ // <-- 👀 버튼을 등록한
        }
    }
    
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM"
        return "\(formatter.string(from: currentDate))-\(date)"
    }
}


#Preview {
    EmotionInputView(date: 1, currentDate: .constant(Date()))
}
