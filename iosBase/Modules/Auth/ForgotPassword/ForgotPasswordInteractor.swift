//
//  ForgotPasswordInteractor.swift
//  iosBase
//
//  Created by Okan Orkun on 5.06.2025.
//

/// Protocol defining the forgot password interactor's responsibilities.
protocol ForgotPasswordInteractorProtocol: BaseInteractorProtocol {
    /// Initiates the forgot password process with the given request.
    /// - Parameter request: ForgotPasswordRequest containing the email.
    func forgotPassword(with request: ForgotPasswordRequest) async throws
}

/// Interactor handling the forgot password use case.
final class ForgotPasswordInteractor: BaseInteractor, ForgotPasswordInteractorProtocol {
    
    private let authManager: AuthenticationManagerProtocol
    
    init(authManager: AuthenticationManagerProtocol) {
        self.authManager = authManager
    }
    
    func forgotPassword(with request: ForgotPasswordRequest) async throws {
        try await authManager.getCurrentStrategy().resetPassword(with: request)
        // Log success message
        print("Email sent successfully")
    }
}
