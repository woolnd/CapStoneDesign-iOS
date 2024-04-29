//
//  View+Notification.swift
//  CapStoneDesign
//
//  Created by Wodnd on 4/30/24.
//

import Foundation

extension View {
    func onNotification(perform action: @escaping (UNNotificationResponse) -> Void) -> some View {
        modifier(NotificationViewModifier(onNotification: action))
    }
}
