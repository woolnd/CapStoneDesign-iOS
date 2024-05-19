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
    @State var currentResponse: Int
    
    @State var vm = EmotionViewModel(emotions: EmotionViewModel.list, weathers: EmotionViewModel.weatherList)
    
    @State private var selectedWeatherIndex: Int?
    
    @State var showImagePicker = false
    @State var selectedUIImage: UIImage?
    @State var imageData: String?
    @State var image: Image?
    @State var title: String = ""
    @State var content: String = ""
    @State var characterCount: Int = 0
    let maxContentLength = 1000
    
    @State var isPresented: Bool = false
    
    
    @FocusState private var focusedField: Field?
    
    enum Field: Hashable {
        case title, content
    }
    
    var service = Service()
    
    func loadImage() {
        guard let selectedImage = selectedUIImage else { return }
        imageData = imageToBase64(selectedImage)
        image = Image(uiImage: selectedImage)
    }
    
    
    var layout: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @ObservedObject var keyboardMonitor : KeyboardMonitor = KeyboardMonitor()
        
    @State var keyboardStatus: KeyboardMonitor.Status = .hide
    
    var body: some View {
        ZStack{
            Image("initial_background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
            GeometryReader{ geo in
                ScrollViewReader { scroll in
                    NavigationStack{
                        ZStack{
                            ScrollView {
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
                                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: -geo.size.width * 0.1))
                                        
                                        Spacer()
                                        
                                        Button(action: {
                                            isPresented = true
                                        }, label: {
                                            Image("introduce")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: geo.size.width * 0.18, height: geo.size.width * 0.18)
                                        })
                                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: geo.size.width * 0.05))
                                    }
                                    
                                    
                                    ZStack{
                                        Image("input_background")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .padding(EdgeInsets(top: -20, leading: 0, bottom: 0, trailing: geo.size.width * 0.06))
                                        
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
                                                        .frame(width: geo.size.width * 0.42, height: geo.size.width * 0.52)
                                                        .clipped()
                                                        .cornerRadius(20)
                                                }else{
                                                    Rectangle()
                                                        .frame(width: geo.size.width * 0.42, height: geo.size.width * 0.52)
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
                                            }
                                            .padding(EdgeInsets(top: -geo.size.width * 0.9, leading: geo.size.width * 0.05, bottom: 0, trailing: 0))
                                            Spacer()
                                        }
                                        
                                        VStack{
                                            Spacer()
                                                .padding()
                                            
                                            TextField("제목을 입력하세요", text: $title)
                                                .font(.custom("777Balsamtint", size: geo.size.width * 0.06))
                                                .frame(width: geo.size.width * 0.6)
                                                .padding(EdgeInsets(top: 0, leading: 0, bottom: geo.size.width * 0.1, trailing: 0))
                                                .onTapGesture {
                                                    withAnimation {
                                                        scroll.scrollTo(Field.title, anchor: .top)
                                                    }
                                                }
                                            
                                            ScrollViewReader{ sv in
                                                ScrollView{
                                                    TextField("일기를 입력하세요", text: $content, axis: .vertical)
                                                        .onAppear(){
                                                            sv.scrollTo(content.count - 1, anchor: .bottom)
                                                        }
                                                        .font(.custom("777Balsamtint", size: geo.size.width * 0.05))
                                                        .frame(width: geo.size.width * 0.85)
                                                        .padding()
                                                        .onTapGesture {
                                                            withAnimation {
                                                                sv.scrollTo(Field.content, anchor: .bottom)
                                                            }
                                                        }.onChange(of: content) {
                                                            withAnimation {
                                                                scroll.scrollTo("ContentTextField", anchor: .bottom)
                                                            }
                                                        }
                                                }
                                                .frame(height: geo.size.width * 0.45)
                                            }
                                            .padding()
                                            
                                            Spacer()
                                                .padding()
                                        }
                                        .padding(EdgeInsets(top: geo.size.width * 0.35, leading: 0, bottom: 0, trailing: geo.size.width * 0.04))
                                        
                                        VStack {
                                            Spacer()
                                            
                                            if(title != "" && content != "" && selectedWeatherIndex != nil){
                                                NavigationLink {
                                                    DiarySendView(requestBody: requestDiary(), currentResponse: currentResponse)
                                                } label: {
                                                    Image("diary_btn_on")
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                        .frame(width: geo.size.width * 0.9)
                                                }
                                            }else{
                                                Image("diary_btn_off")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: geo.size.width * 0.9)
                                            }
                                        }
                                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: geo.size.width * 0.04))
                                        
                                        VStack{
                                            Spacer()
                                            
                                            HStack{
                                                Spacer()
                                                
                                                Text("\(characterCount)/1000")
                                                    .font(Font.custom("777Balsamtint", size: 20))
                                                    .padding(EdgeInsets(top: 0, leading: 0, bottom: geo.size.width * 0.25, trailing: geo.size.width * 0.1))
                                            }
                                            
                                        }
                                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: geo.size.width * 0.04))
                                    }
                                    
                                    
                                }
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: keyboardStatus == .show ? 150 : 0, trailing: 0))
                                .id("ContentTextField")
                                
                                
                            }
                            .accentColor(Color.black)
                        }
                        
                    }
                    .toolbar(.hidden)
                    .navigationBarBackButtonHidden(true)
                    .onChange(of: content) {
                        characterCount = content.count
                        if characterCount > maxContentLength {
                            content = String(content.prefix(maxContentLength))
                        }
                    }
                    .sheet(isPresented: $isPresented, content: {
                        DiaryIntroView()
                    })
                }
            }
            .onTapGesture {
                hideKeyboard()
            }
            .onReceive(self.keyboardMonitor.updatedKeyboardStatusAction, perform: { updatedStatus in
                self.keyboardStatus = updatedStatus
            })
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
    
    func formatReqDate(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        
        let date = dateFormatter.date(from: dateString)
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "yyyy/MM/dd"
        
        return outputFormatter.string(from: date!)
    }
    
    func requestDiary() -> DiaryDto{
        switch selectedWeatherIndex{
        case 0:
            return DiaryDto(dto: Dto(title: title, date: formatReqDate(dateString: currentDate), content: content, emotion: vm.emotions[currentEmotion].imageName, weather: "SUNNY"), image: imageData ?? "")
        case 1:
            return DiaryDto(dto: Dto(title: title, date: formatReqDate(dateString: currentDate), content: content, emotion: vm.emotions[currentEmotion].imageName, weather: "CLOUDY"), image: imageData ?? "")
        default:
            return DiaryDto(dto: Dto(title: title, date: formatReqDate(dateString: currentDate), content: content, emotion: vm.emotions[currentEmotion].imageName, weather: "RAINY"), image: imageData ?? "")
        }
    }
    
    func imageToBase64(_ image: UIImage) -> String? {
        let imageData = image.jpegData(compressionQuality: 1)
        return imageData?.base64EncodedString()
    }
    
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#Preview {
    DiaryInputView(currentDate: "2024-04-18", currentEmotion: 0, currentResponse: 0)
}
