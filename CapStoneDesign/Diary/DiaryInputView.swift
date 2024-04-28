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
    @State var currentEmotion: Int
    
    @State var vm = EmotionViewModel(emotions: EmotionViewModel.list, weathers: EmotionViewModel.weatherList)
    
    @State private var selectedWeatherIndex: Int?
    
    @State var showImagePicker = false
    @State var selectedUIImage: UIImage?
    @State var image: Image?
    @State var title: String = ""
    @State var content: String = ""
    @State var characterCount: Int = 0
    let maxContentLength = 300
    
    @FocusState var isInputActive: Bool
    
    func loadImage() {
        guard let selectedImage = selectedUIImage else { return }
        image = Image(uiImage: selectedImage)
    }
    
    
    var layout: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack{
            ZStack {
                Image("initial_background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                
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
                                    .padding(EdgeInsets(top: 0, leading: -45, bottom: 0, trailing: 0))
                            })
                            
                        }
                        .padding(EdgeInsets(top: -5, leading: 20, bottom: 0, trailing: 20))
                    })
                    
                    ScrollView{
                        ZStack {
                            Image("diary_top")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 20))
                            
                            VStack{
                                Text(formatDate(dateString: currentDate))
                                    .font(.custom("777Balsamtint", size: 18))
                                HStack {
                                    Text("\(vm.emotions[currentEmotion].name)")
                                        .font(.custom("777Balsamtint", size: 18))
                                        .padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 0))
                                    Image("\(vm.emotions[currentEmotion].imageName)")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 60)
                                }
                                .padding(EdgeInsets(top: 17, leading: 0, bottom: 0, trailing: 0))
                                Spacer()
                                
                                LazyVGrid(columns: layout){
                                    ForEach(vm.weathers.indices, id: \.self){ index in
                                        let weaher = vm.weathers[index]
                                        
                                        DiaryWeatherView(weather: weaher)
                                            .opacity(selectedWeatherIndex != nil && selectedWeatherIndex != index ? 0.5 : 1.0)
                                            .onTapGesture {
                                                if let prevSelectedIndex = selectedWeatherIndex {
                                                    vm.weathers[prevSelectedIndex].isSelected = false
                                                }
                                                vm.weathers[index].isSelected.toggle()
                                                selectedWeatherIndex = index
                                            }
                                    }
                                }
                                .frame(width: 150)
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 20))
                            }
                            .padding(EdgeInsets(top: 6, leading: 200, bottom: 0, trailing: 0))
                            HStack {
                                if let image = image {
                                    GeometryReader { geometry in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: min(geometry.size.width, 152), height: 190)
                                            .clipped()
                                            .cornerRadius(20)
                                    }
                                }
                                Spacer()
                            }
                            .padding(EdgeInsets(top: 5, leading: 36, bottom: 0, trailing: 0))
                            
                            HStack{
                                Button(action: {
                                    showImagePicker.toggle()
                                }, label: {
                                    Text("사진 등록하기")
                                        .font(.custom("777Balsamtint", size: 18))
                                        .frame(width: 100)
                                })
                                .sheet(isPresented: $showImagePicker, onDismiss: {
                                    loadImage()
                                }) {
                                    ImagePicker(image: $selectedUIImage)
                                }
                                
                                Spacer()
                            }
                            .padding(EdgeInsets(top: 180, leading: 63, bottom: 0, trailing: 0))
                            
                            
                        }
                        .frame(width: 400)
                        
                        ZStack {
                            Image("diary_content")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 50, trailing: 0))
                            
                            VStack{
                                TextField("제목을 입력하세요", text: $title)
                                    .focused($isInputActive)
                                    .frame(width: 255)
                                    .font(.custom("777Balsamtint", size: 20))
                                    .padding(EdgeInsets(top: 35, leading: 60, bottom: 0, trailing: 0))
                                
                                TextField("일기를 작성하세요", text: $content, axis: .vertical)
                                    .focused($isInputActive)
                                    .frame(width: 300)
                                    .font(.custom("777Balsamtint", size: 20))
                                    .padding(EdgeInsets(top: 50, leading: 0, bottom: 0, trailing: 0))
                                
                                Spacer()
                                Text("\(characterCount)/\(maxContentLength)")
                                    .font(.custom("777Balsamtint", size: 20))
                                    .foregroundColor(characterCount > maxContentLength ? .red : .gray)
                                    .padding(EdgeInsets(top: 0, leading: 250, bottom: 70, trailing: 0))
                            }
                            .toolbar {
                                ToolbarItemGroup(placement: .keyboard) {
                                    Spacer()
                                    
                                    Button("Done") {
                                        isInputActive = false
                                    }
                                }
                            }
                        }
                        .frame(width: 350)
                    }
                    Spacer()
                }
                
                Spacer()
                
                VStack{
                    Spacer()
                    
                    if title != "" && content != "" {
                        NavigationLink {
                            DiarySendView(title: $title, content: $content)
                        } label: {
                            Image(title != "" && content != "" ? "diary_btn_on" : "diary_btn_off" )
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 350)
                        }
                    }
                    else{
                        Image(title != "" && content != "" ? "diary_btn_on" : "diary_btn_off" )
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 350)
                    }

                }
            }
            .accentColor(Color.black)
            
        }
        .toolbar(.hidden)
        .navigationBarBackButtonHidden(true)
        .onChange(of: content) { newValue in
            characterCount = newValue.count
            if characterCount > maxContentLength {
                content = String(newValue.prefix(maxContentLength))
            }
        }
        
    }
    
    func formatDate(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let date = dateFormatter.date(from: dateString)
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "yyyy.MM.dd"
        
        return outputFormatter.string(from: date!)
    }
    
}

#Preview {
    DiaryInputView(currentDate: "2024-04-18", currentEmotion: 0)
}
