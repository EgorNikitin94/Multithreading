//
//  NotificationService.swift
//  Navigation
//
//  Created by Егор Никитин on 27.08.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import UserNotifications

final class  LocalNotificationsService {
    
    func registerForLatestUpdatesIfPossible() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.sound, .badge, .provisional]) { granted, error in
            if granted {
                let center = UNUserNotificationCenter.current()
                center.removeAllPendingNotificationRequests()
                
                let content = UNMutableNotificationContent()
                content.body = "Посмотрите последние уведомления"
                
                var dateComponents = DateComponents()
                dateComponents.hour = 19
                dateComponents.minute = 00
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                center.add(request)
            } else {
                print("Доступ не получен")
            }
        }
    }
    
}
