//
//  LoginInteractor.swift
//  iosBase
//
//  Created by Okan Orkun on 29.05.2025.
//

import Foundation

/// Protocol defining the login interactor responsibilities.
protocol LoginInteractorProtocol: BaseInteractorProtocol {
    /// Performs login with given request.
    /// - Parameter request: LoginRequest containing user credentials.
    func login(with request: LoginRequest) async throws
}

/// Interactor responsible for handling login use case.
final class LoginInteractor: BaseInteractor, LoginInteractorProtocol {
    
    private let authManager: AuthenticationManagerProtocol
    private let sessionManager: SessionManagerProtocol
    
    init(authManager: AuthenticationManagerProtocol, sessionManager: SessionManagerProtocol) {
        self.authManager = authManager
        self.sessionManager = sessionManager
    }
    
    /// Attempts to login and saves user and tokens on success.
    /// - Parameter request: LoginRequest containing user credentials.
    func login(with request: LoginRequest) async throws {
        let response = try await authManager.getCurrentStrategy().login(with: request)
        sessionManager.saveUser(response.user)
        sessionManager.saveAccessToken(response.accessToken)
        sessionManager.saveRefreshToken(response.refreshToken)
    }
}
