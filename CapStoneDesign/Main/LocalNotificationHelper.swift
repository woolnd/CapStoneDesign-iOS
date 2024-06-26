//
//  LocalNotificationHelper.swift
//  CapStoneDesign
//
//  Created by Wodnd on 4/30/24.
//

import Foundation
import UserNotifications

// LocalNotificationHelper.swift
class LocalNotificationHelper {
    static let shared = LocalNotificationHelper()
    
    private init() { }
    
    func setAuthorization() {
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound] // 필요한 알림 권한을 설정
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: { _, _ in }
        )
    }
    
    // PushNotificationHelper.swfit > PushNotificationHelper
    func pushNotification(title: String, body: String, seconds: Double, identifier: String) {
        // 1️⃣ 알림 내용, 설정
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = title
        notificationContent.body = body
        
        // 2️⃣ 조건(시간, 반복)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: false)
        
        // 3️⃣ 요청
        let request = UNNotificationRequest(identifier: identifier,
                                            content: notificationContent,
                                            trigger: trigger)
        
        // 4️⃣ 알림 등록
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Notification Error: ", error)
            }
        }
    }
}
