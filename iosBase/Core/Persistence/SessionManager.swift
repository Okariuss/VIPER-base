//
//  SessionManager.swift
//  iosBase
//
//  Created by Okan Orkun on 31.05.2025.
//

import Foundation

protocol SessionManagerProtocol {
    var currentUser: User? { get }
    var isOnboardingSeen: Bool { get }
    var isLoggedIn: Bool { get }
    var accessToken: String? { get }
    var refreshToken: String? { get }

    func clearAll()
    func performFirstInstallCheck()
    func saveUser(_ user: User)
    func clearUser()
    func markOnboardingAsSeen()
    func saveAccessToken(_ token: String)
    func deleteAccessToken()
    func saveRefreshToken(_ token: String)
    func deleteRefreshToken()
}

/// Manages user session, tokens, and onboarding state.
final class SessionManager: SessionManagerProtocol {
    /// Shared singleton instance of SessionManager.
    static let shared = SessionManager()

    private init() { }

    /// UserDefaults key for onboarding completion.
    private let onboardingKey = "didFinishOnboarding"
    /// Keychain key for access token.
    private let accessTokenKey = "access_token"
    /// Keychain key for refresh token.
    private let refreshTokenKey = "refresh_token"

    /// The currently logged-in user, if any.
    private(set) var currentUser: User?

    /// Clears all session data including tokens and user info.
    func clearAll() {
        deleteAccessToken()
        deleteRefreshToken()
        clearUser()
    }

    /// Performs check on first install to clear session if onboarding not completed.
    func performFirstInstallCheck() {
        if !isOnboardingSeen {
            clearAll()
        }
    }

    // MARK: - User

    /// Saves the current user in session.
    /// - Parameter user: The user object to save.
    func saveUser(_ user: User) {
        self.currentUser = user
    }

    /// Clears the current user from session.
    func clearUser() {
        self.currentUser = nil
    }

    // MARK: - Onboarding

    /// Returns whether onboarding has been seen by the user.
    var isOnboardingSeen: Bool {
        UserDefaults.standard.bool(forKey: onboardingKey)
    }

    /// Marks onboarding as seen in user defaults.
    func markOnboardingAsSeen() {
        UserDefaults.standard.set(true, forKey: onboardingKey)
    }

    // MARK: - Authentication

    /// Returns whether the user is logged in based on presence of access token.
    var isLoggedIn: Bool {
        accessToken != nil
    }

    // MARK: - Access Token

    /// Retrieves the access token securely from the keychain.
    var accessToken: String? {
        KeychainHelper.shared.read(key: accessTokenKey)
    }

    /// Saves the access token securely to the keychain.
    /// - Parameter token: The access token string.
    func saveAccessToken(_ token: String) {
        KeychainHelper.shared.save(token, key: accessTokenKey)
    }

    /// Deletes the access token from the keychain.
    func deleteAccessToken() {
        KeychainHelper.shared.delete(key: accessTokenKey)
    }

    // MARK: - Refresh Token

    /// Retrieves the refresh token securely from the keychain.
    var refreshToken: String? {
        KeychainHelper.shared.read(key: refreshTokenKey)
    }

    /// Saves the refresh token securely to the keychain.
    /// - Parameter token: The refresh token string.
    func saveRefreshToken(_ token: String) {
        KeychainHelper.shared.save(token, key: refreshTokenKey)
    }

    /// Deletes the refresh token from the keychain.
    func deleteRefreshToken() {
        KeychainHelper.shared.delete(key: refreshTokenKey)
    }
}
