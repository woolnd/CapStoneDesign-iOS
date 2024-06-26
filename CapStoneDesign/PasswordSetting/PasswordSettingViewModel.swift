//
//  PasswordSettingViewModel.swift
//  CapStoneDesign
//
//  Created by Wodnd on 5/2/24.
//

import Foundation
import Combine
import SwiftUI
class PasswordSettingViewModel : ObservableObject {
    @Published var passwordFieldArray : [Int] = []
    @Published var isPasswordRegisterFinish : Bool = false
    fileprivate var APP_SCREEN_LOCK_PASSWORD = "AppScreenLockPassWord"
    var subscription = Set<AnyCancellable>()
    
    
    func resetPasswordArray() {
        passwordFieldArray = []
    }
    
    func deleteLastIndexPasswordArray(){
        passwordFieldArray = passwordFieldArray.dropLast()
        print("\(passwordFieldArray)")
    }
    
    func setObserver() {
        $passwordFieldArray
            .removeDuplicates()
            .subscribe(on: DispatchQueue.main)
            .sink { [weak self] value in
                if value.count == 4 {
                    print("PASSWORD REGISTER")
                    setUD(key: self?.APP_SCREEN_LOCK_PASSWORD ?? "", value: value)
                    
                    DispatchQueue.main.async { [weak self] in
                        self?.resetPasswordArray()
                        self?.isPasswordRegisterFinish = true
                        print("PASSWORD FINISH")
                    }
                }
                else if value.count > 4 {
                    print("OVER PASSWORD DELETE")
                    DispatchQueue.main.async { [weak self] in
                        let prefixedPassword = value.prefix(4)
                        self?.passwordFieldArray = Array(prefixedPassword)
                    }
                    print("\(String(describing: self?.passwordFieldArray))")
                }
            }
            .store(in: &subscription)
    }
}
