//
//  SignupPresenter.swift
//  iosBase
//
//  Created by Okan Orkun on 29.05.2025.
//

import Foundation

@MainActor
protocol SignupPresenterProtocol: BasePresenterProtocol {
    /// Called when the user taps the signup button.
    /// - Parameter request: The signup request containing user data.
    func didTapSignupButton(with request: SignupRequest)
    
    /// Called when the user taps the sign-in button to return to login.
    func didTapSigninButton()
}

/// Presenter responsible for handling Signup screen logic.
@MainActor
final class SignupPresenter: BasePresenter {
    private weak var view: SignupViewController?
    private let interactor: SignupInteractorProtocol
    private let router: SignupRouterProtocol

    /// Initializes the presenter with dependencies.
    /// - Parameters:
    ///   - view: The signup view controller.
    ///   - interactor: The signup interactor.
    ///   - router: The signup router.
    init(view: SignupViewController, interactor: SignupInteractorProtocol, router: SignupRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }

    override func viewDidLoad() {
        Logger.log("Signup screen loaded")
    }
}

extension SignupPresenter: SignupPresenterProtocol, ValidationManager {
    
    func didTapSignupButton(with request: SignupRequest) {
        Logger.log("Signup attempt with \(request.email)")
        Task {
            view?.showLoading(true)
            defer { view?.showLoading(false) }
            do {
                try validateSignup(request: request)
                try await interactor.signup(with: request)
                await router.navigate(to: .home)
            } catch {
                Logger.log("Signup failed: \(error.localizedDescription)")
                view?.showAlert(message: error.localizedDescription)
            }
        }
    }
    
    func didTapSigninButton() {
        Task {
            await router.navigate(to: .signin)
        }
    }
}
