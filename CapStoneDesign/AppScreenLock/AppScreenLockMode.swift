//
//  AppScreenLockMode.swift
//  CapStoneDesign
//
//  Created by Wodnd on 5/2/24.
//

import Foundation

enum AppScreenLockMode {
    case OnScreenLock
    case OffScreenLock
    case NoScreenLock
    
    func getMessageAppScreenLockMode() {
        switch self {
        case.NoScreenLock :
            print("USER DON'T SET SCREEN LOCK")
        case.OffScreenLock :
            print("USER RESOLVE SCREEN LOCK")
        case.OnScreenLock :
            print("APP SCREEN LOCK ON & USER NEED TO ENTER THEIR PASSWORD")
        }
    }
}
