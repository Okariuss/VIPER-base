//
//  AppEnvironment.swift
//  iosBase
//
//  Created by Okan Orkun on 29.05.2025.
//

import Foundation

/// Defines base URL configuration based on build environment.
enum AppEnvironment {
    static let baseURL: String = {
        #if DEBUG
        // Development environment
        return "https://dev.api.example.com"
        #elseif PROD
        // Production environment
        return "https://api.example.com"
        #else
        // Staging environment
        return "https://staging.api.example.com"
        #endif
    }()
}
