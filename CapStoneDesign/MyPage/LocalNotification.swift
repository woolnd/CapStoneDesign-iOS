import UserNotifications
import CoreLocation

class NotificationManager {
    static let instance = NotificationManager()
    private init() {}
    
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { (success, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("SUCCESS")
            }
        }
    }
    
    enum TriggerType: String {
        case time = "time"
        
        var trigger: UNNotificationTrigger {
            switch self {
            case .time:
                return UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            }
        }
    }
    
    func scheduleNotification(trigger: TriggerType) {
        let content = UNMutableNotificationContent()
        content.title = "푸시 알림 테스트입니다"
        content.subtitle = "정말될까?!"
        content.sound = .default
        content.badge = 1
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger.trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    func cancelNotification() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
}
