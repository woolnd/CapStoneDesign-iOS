//
//  DiaryInputView.swift
//  CapStoneDesign
//
//  Created by Wodnd on 4/13/24.
//

import SwiftUI
import Combine

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
    @State var imageData: Data = UIImage(named: "initial_last_logo")!.pngData()!
    let maxContentLength = 1000
    
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
        GeometryReader{ geo in
            NavigationStack{
                ZStack {
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
                                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                                
                            })
                            
                            Spacer()
                            
                            Text("MoodMingle")
                                .font(.custom("KyoboHandwriting2021sjy", size: 25))
                                .padding(EdgeInsets(top: 0, leading: 40, bottom: 0, trailing: 0))
                            
                            Spacer()
                            
                            Button(action: {
                                
                            }, label: {
                                Image("introduce")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 70,height: 70)
                            })
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                        }
                        
                        ZStack{
                            Image("input_background")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding(EdgeInsets(top: -20, leading: 0, bottom: 0, trailing: 10))
                            
                            HStack{
                                VStack{
                                    
                                    HStack{
                                        Text("날짜: \(formatDate(dateString: currentDate))")
                                            .font(.custom("777Balsamtint", size: geo.size.width * 0.05))
                                    }
                                    
                                    HStack{
                                        Text("감정: \(vm.emotions[currentEmotion].name)")
                                            .font(.custom("777Balsamtint", size: geo.size.width * 0.05))
                                            .padding(EdgeInsets(top: 17, leading: 0, bottom: 0, trailing: 0))
                                        
                                        Image("\(vm.emotions[currentEmotion].imageName)")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: geo.size.width * 0.16)
                                    }
                                    
                                    HStack{
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
                                        .frame(width: geo.size.width * 0.4)
                                    }
                                    
                                    Spacer()
                                }
                            }
                            .offset(CGSize(width: geo.size.width * 0.22, height: geo.size.height * 0.025))
                            HStack{
                                VStack{
                                    if let image = image {
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: geo.size.width * 0.4, height: geo.size.height * 0.27)
                                            .clipped()
                                            .cornerRadius(20)
                                    }else{
                                        Rectangle()
                                            .frame(width: geo.size.width * 0.4, height: geo.size.height * 0.27)
                                            .clipped()
                                            .cornerRadius(20)
                                            .foregroundColor(.clear)
                                    }
                                    
                                    Button(action: {
                                        showImagePicker.toggle()
                                    }, label: {
                                        Text("사진 등록하기")
                                            .font(.custom("777Balsamtint", size: geo.size.width * 0.05))
                                    })
                                    .sheet(isPresented: $showImagePicker, onDismiss: {
                                        loadImage()
                                    }) {
                                        ImagePicker(image: $selectedUIImage)
                                    }
                                    
                                    Spacer()
                                }
                                Spacer()
                            }
                            VStack{
                                
                                TextField("제목을 입력하세요", text: $title)
                                    .submitLabel(.done)  //  "검색" 버튼
                                    .font(.custom("777Balsamtint", size: geo.size.width * 0.06))
                                    .frame(width: geo.size.width * 0.65)
                                
                                ScrollViewReader{ sv in
                                    ScrollView{
                                        TextField("일기를 입력하세요", text: $content, axis: .vertical)
                                            .submitLabel(.done)
                                            .font(.custom("777Balsamtint", size: geo.size.width * 0.05))
                                            .onAppear(){
                                                sv.scrollTo(content.count - 1, anchor: .bottom)
                                            }
                                    }
                                    .padding(EdgeInsets(top: 0, leading: 40, bottom: 0, trailing: 40))
                                }
                            }
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
