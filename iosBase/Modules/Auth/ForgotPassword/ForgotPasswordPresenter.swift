//
//  ForgotPasswordPresenter.swift
//  iosBase
//
//  Created by Okan Orkun on 5.06.2025.
//

import Foundation

@MainActor
protocol ForgotPasswordPresenterProtocol: BasePresenterProtocol {
    /// Called when the user taps the forgot password button.
    /// - Parameter request: The forgot password request containing the user's email.
    func didTapForgotPasswordButton(with request: ForgotPasswordRequest)
}

/// Presenter handling forgot password screen logic.
@MainActor
final class ForgotPasswordPresenter: BasePresenter {
    private weak var view: ForgotPasswordViewController?
    private let interactor: ForgotPasswordInteractorProtocol
    private let router: ForgotPasswordRouterProtocol

    /// Initializes the presenter with required dependencies.
    /// - Parameters:
    ///   - view: The view controller for the forgot password screen.
    ///   - interactor: The interactor handling business logic.
    ///   - router: The router handling navigation.
    init(
        view: ForgotPasswordViewController,
        interactor: ForgotPasswordInteractorProtocol,
        router: ForgotPasswordRouterProtocol
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }

    override func viewDidLoad() {
        Logger.log("Forgot Password screen loaded")
    }
}

extension ForgotPasswordPresenter: ForgotPasswordPresenterProtocol, ValidationManager {
    /// Handles the forgot password button tap event.
    /// - Parameter request: The forgot password request containing the user's email.
    func didTapForgotPasswordButton(with request: ForgotPasswordRequest) {
        Logger.log("Forgot Password attempt with \(request.email)")
        Task {
            view?.showLoading(true)
            defer { view?.showLoading(false) }
            do {
                try validateEmail(request: request)
                try await interactor.forgotPassword(with: request)
                await router.navigate(to: .login)
                view?.showAlert(
                    title: Localization.Common.ok.text,
                    message: Localization.Authentication.forgotPasswordText.text
                )
            } catch {
                Logger.log("Forgot Password failed: \(error.localizedDescription)")
                view?.showAlert(title: Localization.Common.error.text, message: error.localizedDescription)
            }
        }
    }
}
