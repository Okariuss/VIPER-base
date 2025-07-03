//
//  SignupInteractor.swift
//  iosBase
//
//  Created by Okan Orkun on 29.05.2025.
//

import Foundation

/// Protocol defining the responsibilities for signup interactor.
protocol SignupInteractorProtocol: BaseInteractorProtocol {
    /// Performs signup with the given request.
    /// - Parameter request: SignupRequest containing user details.
    func signup(with request: SignupRequest) async throws
}

/// Interactor responsible for handling the signup use case.
final class SignupInteractor: BaseInteractor, SignupInteractorProtocol {
    
    private let authManager: AuthenticationManagerProtocol
    private let sessionManager: SessionManagerProtocol
    
    init(
        authManager: AuthenticationManagerProtocol,
        sessionManager: SessionManagerProtocol
    ) {
        self.authManager = authManager
        self.sessionManager = sessionManager
    }
    
    /// Attempts to sign up the user and saves user data and tokens on success.
    /// - Parameter request: SignupRequest containing user details.
    func signup(with request: SignupRequest) async throws {
        let response = try await authManager.getCurrentStrategy().signup(with: request)
        sessionManager.saveUser(response.user)
        sessionManager.saveAccessToken(response.accessToken)
        sessionManager.saveRefreshToken(response.refreshToken)
    }
}
