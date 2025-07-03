//
//  LoginPresenter.swift
//  iosBase
//
//  Created by Okan Orkun on 29.05.2025.
//

import Foundation

@MainActor
protocol LoginPresenterProtocol: BasePresenterProtocol {
    /// Called when the user taps the Forgot Password button.
    func didTapForgotPasswordButton()
    
    /// Called when the user taps the Sign Up button.
    func didTapSignUpButton()
    
    /// Called when the user taps the Login button with the given request.
    /// - Parameter request: The login request containing user credentials.
    func didTapLoginButton(with request: LoginRequest)
}

/// Presenter responsible for handling the Login screen logic.
@MainActor
final class LoginPresenter: BasePresenter {
    private weak var view: LoginViewController?
    private let interactor: LoginInteractorProtocol
    private let router: LoginRouterProtocol
    
    /// Initializes the presenter with dependencies.
    /// - Parameters:
    ///   - view: The login view controller.
    ///   - interactor: The login interactor.
    ///   - router: The login router.
    init(view: LoginViewController, interactor: LoginInteractorProtocol, router: LoginRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    override func viewDidLoad() {
        Logger.log("Login screen loaded")
    }
}

extension LoginPresenter: LoginPresenterProtocol, ValidationManager {
    
    /// Handles tap on the Forgot Password button.
    func didTapForgotPasswordButton() {
        router.navigate(to: .forgotPassword)
    }
    
    /// Handles tap on the Sign Up button.
    func didTapSignUpButton() {
        router.navigate(to: .signup)
    }
    
    /// Handles tap on the Login button.
    /// Validates the request, performs login, and navigates on success.
    /// Shows error alert on failure.
    /// - Parameter request: The login request containing user credentials.
    func didTapLoginButton(with request: LoginRequest) {
        Logger.log("Login attempt with \(request.email)")
        Task {
            self.view?.showLoading(true)
            defer { self.view?.showLoading(false) }

            do {
                try validateLogin(request: request)
                try await interactor.login(with: request)
                self.router.navigate(to: .home)
            } catch {
                Logger.log("Login failed: \(error.localizedDescription)")
                self.view?.showAlert(message: error.localizedDescription)
            }
        }
    }
}
