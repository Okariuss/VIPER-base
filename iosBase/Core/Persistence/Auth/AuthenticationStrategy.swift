//
//  APIAuthenticationStrategy.swift
//  iosBase
//
//  Created by Okan Orkun on 29.05.2025.
//

import Foundation

/// Defines methods for authentication strategies.
protocol AuthenticationStrategy {
    func login(with request: LoginRequest) async throws -> LoginResponse
    func signup(with request: SignupRequest) async throws -> LoginResponse
    func logout() async throws
    func resetPassword(with request: ForgotPasswordRequest) async throws
    func refreshToken() async throws -> String
}

// MARK: - API Authentication Strategy

/// Implementation of `AuthenticationStrategy` using custom API backend.
final class APIAuthenticationStrategy: AuthenticationStrategy {
    private let networkManager: NetworkServiceProtocol

    init(networkManager: NetworkServiceProtocol = NetworkService.shared) {
        self.networkManager = networkManager
    }

    func login(with request: LoginRequest) async throws -> LoginResponse {
        let endpoint = APIEndpoint.login(email: request.email, password: request.password)
        let response: LoginResponse = try await networkManager.request(endpoint: endpoint)
        return response
    }

    func signup(with request: SignupRequest) async throws -> LoginResponse {
        let endpoint = APIEndpoint.signup(email: request.email, password: request.password, name: request.username)
        let response: LoginResponse = try await networkManager.request(endpoint: endpoint)
        return response
    }

    func logout() async throws {
        let endpoint = APIEndpoint.logout
        let _: EmptyResponse = try await networkManager.request(endpoint: endpoint)
    }

    func resetPassword(with request: ForgotPasswordRequest) async throws {
        let endpoint = APIEndpoint.resetPassword(email: request.email)
        let _: EmptyResponse = try await networkManager.request(endpoint: endpoint)
    }

    func refreshToken() async throws -> String {
        let endpoint = APIEndpoint.refreshToken
        return try await networkManager.request(endpoint: endpoint)
    }
}

// MARK: - Firebase Authentication Strategy

/// Implementation of `AuthenticationStrategy` using Firebase Authentication.
final class FirebaseAuthenticationStrategy: AuthenticationStrategy {
    private let firebaseAuth: FirebaseAuthServiceProtocol

    init(firebaseAuth: FirebaseAuthServiceProtocol = FirebaseAuthService.shared) {
        self.firebaseAuth = firebaseAuth
    }

    func login(with request: LoginRequest) async throws -> LoginResponse {
        let (firebaseUser, idToken) = try await firebaseAuth.signIn(email: request.email, password: request.password)
        return LoginResponse(user: User(from: firebaseUser), accessToken: idToken, refreshToken: "", expiresIn: 3600)
    }

    func signup(with request: SignupRequest) async throws -> LoginResponse {
        let (firebaseUser, idToken) = try await firebaseAuth.createUser(email: request.email, password: request.password, username: request.username)
        return LoginResponse(user: User(from: firebaseUser), accessToken: idToken, refreshToken: "", expiresIn: 3600)
    }

    func logout() async throws {
        try await firebaseAuth.signOut()
        SessionManager.shared.clearAll()
    }

    func resetPassword(with request: ForgotPasswordRequest) async throws {
        try await firebaseAuth.sendPasswordReset(email: request.email)
    }

    func refreshToken() async throws -> String {
        return try await firebaseAuth.refreshToken()
    }
}
