//
//  AppCheckManager.swift
//  iosBase
//
//  Created by Okan Orkun on 9.06.2025.
//

import Firebase
import FirebaseAppCheck

/// Manages Firebase App Check configuration for the application.
final class AppCheckManager: NSObject {
    static let shared = AppCheckManager()

    /// Sets up the appropriate App Check provider factory based on the build configuration.
    func setup() {
    #if DEBUG
        let appCheckManager = AppCheckDebugProviderFactory()
    #else
        let appCheckManager = SimpleAppCheckProviderFactory()
    #endif
        AppCheck.setAppCheckProviderFactory(appCheckManager)
    }
}

/// Provides a simple App Check provider factory that returns the appropriate provider
/// based on the iOS version.
final class SimpleAppCheckProviderFactory: NSObject, AppCheckProviderFactory {
    func createProvider(with app: FirebaseApp) -> AppCheckProvider? {
        if #available(iOS 14.0, *) {
            return AppAttestProvider(app: app)
        } else {
            return DeviceCheckProvider(app: app)
        }
    }
}
