//
//  NotificationManager.swift
//  Kuban Kredit Test
//
//  Created by Антон Захарченко on 23.12.2019.
//  Copyright © 2019 Антон Захарченко. All rights reserved.
//

import Foundation
import UserNotifications

struct NotificationManager {
    let center = UNUserNotificationCenter.current()
    let content = UNMutableNotificationContent()
    
    func requestNotifications() {
        center.requestAuthorization(options: [.sound, .alert, .badge]) { (granted, error) in
        }
    }
    
    func sendNotification() {
        content.title = "New request!"
        content.body = "The app has sent a new request. Open the app to see details."
        
        let dateComponent = Calendar.current.dateComponents([.year, .month, .hour, .minute, .second], from: .init(timeIntervalSinceNow: 1))
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: false)
        let request = UNNotificationRequest(identifier: "content", content: content, trigger: trigger)
        
        center.add(request) { (error) in
            if let e = error {
                print(e)
            }
        }
    }
    
}

