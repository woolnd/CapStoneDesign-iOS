//
//  StateManager.swift
//  CapStoneDesign
//
//  Created by Wodnd on 5/2/24.
//

import Foundation

/// Mark: - StateManager
/// 앱의 네비게이션 태그나, isPresented와 같이 @State등에 쓰이는 변수들을 모아놓은 곳
/// window 쪽에 @StateObject로 선언되어 앱의 init이나 LifeCycle에 영향받지 않는다.
class StateManager: ObservableObject {

    // AppScreenLockView
    @Published var isForgetPasswordState : Bool = false
    
    // PasswordSettingView
    @Published var isPasswordSettingView : Bool = false
    @Published var isPasswordSetting : Bool = false
    
    fileprivate var APP_SCREEN_LOCK_PASSWORD = "AppScreenLockPassWord"
    
    func checkIsUserSetPassword() {
        let AppScreenLockPassword = getUD(key: APP_SCREEN_LOCK_PASSWORD)
        if AppScreenLockPassword as! [Int] == [] {
            
            isPasswordSetting = false
        } else {
            // User Set Password
            isPasswordSetting = true
        }
    }
}
