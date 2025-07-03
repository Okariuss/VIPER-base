//
//  FirebaseAnalyticsService.swift
//  iosBase
//
//  Created by Okan Orkun on 7.06.2025.
//

import Foundation
import Firebase

@MainActor
final class FirebaseAnalyticsService: AnalyticsService {

    static let shared = FirebaseAnalyticsService()

    /// Initializes Firebase and loads configuration settings
    func setup() {
        guard
            let googleServicesPath = Bundle.main.object(forInfoDictionaryKey: "GoogleServicesFileName") as? String,
            let filePath = Bundle.main.path(forResource: googleServicesPath, ofType: "plist"),
            let firebaseOptions = FirebaseOptions(contentsOfFile: filePath)
        else {
            print("Failed to initialize firebase options, please check your configuration settings")
            return
        }
        FirebaseApp.configure(options: firebaseOptions)
    }

    /// Identifies the user in Firebase Analytics
    /// - Parameter userId: The user's identifier
    func identifyUser(with userId: String) {
        Analytics.setUserID(userId)
    }

    /// Logs an analytics event
    /// - Parameter event: The analytics event to log
    func log(event: AnalyticsEvent) {
        Analytics.logEvent(event.name, parameters: event.parameters)
    }

    /// Resets analytics data
    func reset() {
        Analytics.resetAnalyticsData()
    }
}
