//
//  TokenManager.swift
//  CapStoneDesign
//
//  Created by Wodnd on 5/5/24.
//

import Foundation

final class TokenManager: ObservableObject{
    @Published var kakaoToken: String?
    
    
    init() {
        // 초기화할 때 UserDefaults에서 값을 가져와 설정
        kakaoToken = UserDefaults.standard.string(forKey: "KakaoToken")}
        
}
