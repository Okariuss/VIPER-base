//
//  AuthenticationManager.swift
//  iosBase
//
//  Created by Okan Orkun on 29.05.2025.
//

import Foundation

/// Defines the supported authentication types.
enum AuthenticationType {
    case api
    case firebase
}

protocol AuthenticationManagerProtocol {
    func getCurrentStrategy() -> AuthenticationStrategy
}

/// Manages authentication strategy based on the selected authentication type.
final class AuthenticationManager: AuthenticationManagerProtocol {
    static let shared = AuthenticationManager()
    private init() {}

    private var currentStrategy: AuthenticationStrategy?

    /// Configures the authentication strategy based on the given type.
    /// - Parameter type: The authentication type to configure.
    func configure(with type: AuthenticationType) {
        currentStrategy = {
            switch type {
            case .api: return APIAuthenticationStrategy()
            case .firebase: return FirebaseAuthenticationStrategy()
            }
        }()
    }

    /// Returns the currently configured authentication strategy.
    /// - Returns: The current `AuthenticationStrategy`.
    /// - Throws: Fatal error if strategy is not configured before usage.
    func getCurrentStrategy() -> AuthenticationStrategy {
        guard let strategy = currentStrategy else {
            fatalError("Authentication strategy not configured. Call configure(with:) first.")
        }
        return strategy
    }
}
