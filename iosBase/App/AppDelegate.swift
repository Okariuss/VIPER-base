//
//  AppDelegate.swift
//  iosBase
//
//  Created by Okan Orkun on 28.05.2025.
//

import UIKit
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    /// Called when the application has finished launching.
    /// Sets up Firebase Analytics, App Check, and Authentication.
    @MainActor
    public func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        FirebaseAnalyticsService.shared.setup()
        AppCheckManager.shared.setup()
        AuthenticationManager.shared.configure(with: .firebase)
        return true
    }

    // MARK: - UISceneSession Lifecycle

    @MainActor
    public func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        // Select a configuration to create the new scene with.
        UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @MainActor
    public func application(
        _ application: UIApplication,
        didDiscardSceneSessions sceneSessions: Set<UISceneSession>
    ) {
        // Release resources specific to discarded scenes if needed.
    }
}
