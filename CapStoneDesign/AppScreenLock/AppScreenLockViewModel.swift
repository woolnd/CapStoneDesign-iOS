//
//  AppScreenLockViewModel.swift
//  CapStoneDesign
//
//  Created by Wodnd on 5/2/24.
//

import Foundation
import Combine

class AppScreenLockViewModel : ObservableObject {
    
    @Published var appScreenLockMode : AppScreenLockMode?
    @Published var passwordFieldArray : [Int] = []
    @Published var password : String = ""
    @Published var isWrongPassword : Bool = false
    fileprivate var APP_SCREEN_LOCK_PASSWORD = "AppScreenLockPassWord"
    
    var subscription = Set<AnyCancellable>()
    
    // 유저가 스크린 락을 설정했는지 안 했는지 확인한다.
    func checkIsUserSetScreenLockPassword() {
        let AppScreenLockPassword = getUD(key: APP_SCREEN_LOCK_PASSWORD)
        if AppScreenLockPassword as! [Int] == [] {
            // User Doesn't Set Password
            appScreenLockMode = .NoScreenLock
            appScreenLockMode?.getMessageAppScreenLockMode()
        } else {
            // User Set Password
            appScreenLockMode = .OnScreenLock
            appScreenLockMode?.getMessageAppScreenLockMode()
        }
    }
    
    // 리프래시 이미지 버튼
    func resetPasswordArray() {
        passwordFieldArray = []
    }
    
    // 백스페이스 이미지 버튼
    func deleteLastIndexPasswordArray(){
        passwordFieldArray = passwordFieldArray.dropLast()
        print("\(passwordFieldArray)")
    }
    
    // 비밀번호 초기화 메서드
    func clearPassword() {
        UserDefaults.standard.set([], forKey: APP_SCREEN_LOCK_PASSWORD)
        passwordFieldArray = []
        appScreenLockMode = .NoScreenLock
    }
    
    /// Mark: - setObserver
    /// feature : 유저가 4자리를 입력하면 비밀번호가 맞는지 여부를 체크한다.
    /// 비밀번호가 맞으면 appScreenLockMode의 상태를 바꿔 잠금을 해제하고
    /// 비밀번호가 틀리면 비밀번호를 리셋하고 비밀번호가 흔들리는 shake애니메이션을 실행시킨다.
    func setObserver() {
        let asswordFieldArraysubscriber: () = $passwordFieldArray
            .removeDuplicates()
            .subscribe(on: DispatchQueue.main)
            .sink { value in
                if value.count == 4 {
                    print("PASSWORD CHECK")
                    if value == getUD(key: self.APP_SCREEN_LOCK_PASSWORD) as! [Int] {
                        DispatchQueue.main.async { [self] in
                            self.resetPasswordArray()
                            appScreenLockMode = .OffScreenLock
                        }
                    } else {
                        DispatchQueue.main.async { [self] in
                            self.resetPasswordArray()
                            isWrongPassword = true
                            print("RESET")
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                self.isWrongPassword = false
                            }
                        }
                    }
                    
                }
            }
            .store(in: &subscription)
    }
    
}
