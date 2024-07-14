//
//  DataController-Notifications.swift
//  UltimatePortfolio
//
//  Created by David Ash on 14/07/2024.
//

import Foundation
import UserNotifications

extension DataController {
    func addReminder(for issue: Issue) async -> Bool {
        do {
            let center = UNUserNotificationCenter.current()
            let settings = await center.notificationSettings()

            switch settings.authorizationStatus {
            case .notDetermined:
                let success = try await requestNotficiations()

                if success {
                    try await placeReminder(for: issue)
                } else {
                    return false
                }

            case .authorized:
                try await placeReminder(for: issue)

            default:
                return false
            }

            return true
        } catch {
            return false
        }
    }

    func removeReminders(for issue: Issue) {
        let center = UNUserNotificationCenter.current()
        let id = issue.objectID.uriRepresentation().absoluteString
        center.removePendingNotificationRequests(withIdentifiers: [id])
    }

    private func requestNotficiations() async throws -> Bool {
        let center = UNUserNotificationCenter.current()
        return try await center.requestAuthorization(options: [.alert, .sound])
    }

    private func placeReminder(for issue: Issue) async throws {
        let content = UNMutableNotificationContent()
        content.title = issue.issueTitle
        content.sound = .default

        if let issueContent = issue.content {
            content.subtitle = issueContent
        }

//        let components = Calendar.current.dateComponents([.hour, .minute], from: issue.issueReminderTime)
//        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false) // for testing purposes ONLY

        let id = issue.objectID.uriRepresentation().absoluteString
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)

        return try await UNUserNotificationCenter.current().add(request)
    }
}
