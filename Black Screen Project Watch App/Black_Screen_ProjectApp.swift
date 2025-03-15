import SwiftUI
import UserNotifications

@main
struct TurnOffScreenApp: App {
    // Monitor the app’s lifecycle
    @Environment(\.scenePhase) private var scenePhase

    init() {
        // Set up the notification action and category
        let action = UNNotificationAction(identifier: "TURN_OFF_SCREEN_ACTION",
                                          title: "Turn off the screen",
                                          options: [.foreground])
        let category = UNNotificationCategory(identifier: "TURN_OFF_SCREEN",
                                              actions: [action],
                                              intentIdentifiers: [],
                                              options: [])
        UNUserNotificationCenter.current().setNotificationCategories([category])
        
        // Request permission to show alerts and play sounds
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
            if let error = error {
                print("Notification permission error: \(error)")
            } else {
                print("Notification permissions granted: \(granted)")
            }
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        // Listen for changes in the scene phase (active, inactive, background)
        .onChange(of: scenePhase) {
            if scenePhase == .background {
                scheduleNotification()
            }
        }
    }
    
    /// Schedules a notification that will fire after 1 second.
    private func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Turn off the screen"
        content.body = "Tap to return to the app."
        content.categoryIdentifier = "TURN_OFF_SCREEN"
        
        // The trigger is set for 1 second from now.
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: "turnOffScreenNotification",
                                            content: content,
                                            trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error)")
            } else {
                print("Notification scheduled successfully.")
            }
        }
    }
}
