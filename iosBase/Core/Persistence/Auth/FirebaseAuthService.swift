//
//  FirebaseAuthService.swift
//  iosBase
//
//  Created by Okan Orkun on 29.05.2025.
//

import Foundation
import FirebaseAuth

/// Protocol defining Firebase authentication service methods.
protocol FirebaseAuthServiceProtocol {
    /// Signs in a user with email and password.
    /// - Parameters:
    ///   - email: The user's email.
    ///   - password: The user's password.
    /// - Returns: A tuple containing the Firebase user and ID token.
    func signIn(email: String, password: String) async throws -> (FirebaseAuth.User, String)

    /// Creates a new user with email, password, and username.
    /// - Parameters:
    ///   - email: The user's email.
    ///   - password: The user's password.
    ///   - username: The user's display name.
    /// - Returns: A tuple containing the Firebase user and ID token.
    func createUser(email: String, password: String, username: String) async throws -> (FirebaseAuth.User, String)

    /// Signs out the current user.
    func signOut() async throws

    /// Sends a password reset email.
    /// - Parameter email: The email to send the reset link to.
    func sendPasswordReset(email: String) async throws

    /// Refreshes the current user's ID token.
    /// - Returns: A refreshed ID token string.
    func refreshToken() async throws -> String
}

/// Implementation of Firebase authentication service using FirebaseAuth SDK.
final class FirebaseAuthService: FirebaseAuthServiceProtocol {
    /// Shared singleton instance.
    static let shared = FirebaseAuthService()
    private init() {}

    /// Signs in a user with email and password.
    /// - Parameters:
    ///   - email: The user's email.
    ///   - password: The user's password.
    /// - Returns: A tuple containing the Firebase user and ID token.
    func signIn(email: String, password: String) async throws -> (FirebaseAuth.User, String) {
        let result = try await Auth.auth().signIn(withEmail: email, password: password)
        let user = result.user
        let idToken = try await user.getIDToken()
        return (user, idToken)
    }

    /// Creates a new user with email, password, and username.
    /// - Parameters:
    ///   - email: The user's email.
    ///   - password: The user's password.
    ///   - username: The user's display name.
    /// - Returns: A tuple containing the Firebase user and ID token.
    func createUser(email: String, password: String, username: String) async throws -> (FirebaseAuth.User, String) {
        let result = try await Auth.auth().createUser(withEmail: email, password: password)
        // Update display name
        let changeRequest = result.user.createProfileChangeRequest()
        changeRequest.displayName = username
        try await changeRequest.commitChanges()
        let user = result.user
        let idToken = try await user.getIDToken()
        return (user, idToken)
    }

    /// Signs out the current user.
    func signOut() async throws {
        try Auth.auth().signOut()
    }

    /// Sends a password reset email.
    /// - Parameter email: The email to send the reset link to.
    func sendPasswordReset(email: String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }

    /// Refreshes the current user's ID token.
    /// - Returns: A refreshed ID token string.
    /// - Throws: An error if there is no current user.
    func refreshToken() async throws -> String {
        guard let currentUser = Auth.auth().currentUser else {
            throw NSError(domain: "FirebaseAuthService", code: 401, userInfo: [NSLocalizedDescriptionKey: "No current user found"])
        }
        return try await currentUser.getIDToken()
    }
}
