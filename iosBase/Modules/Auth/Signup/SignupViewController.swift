//
//  SignupViewController.swift
//  iosBase
//
//  Created by Okan Orkun on 29.05.2025.
//

import UIKit

/// View controller responsible for displaying and handling the Signup screen.
final class SignupViewController: BaseViewController {
    var presenter: SignupPresenterProtocol!

    private lazy var usernameTextField = CustomTextField(
        type: .normal,
        placeholderText: Localization.Authentication.name.text,
        image: AppConstants.SystemImages.card.toSelected
    )
    private lazy var emailTextField = CustomTextField(
        type: .email,
        placeholderText: Localization.Authentication.email.text,
        image: AppConstants.SystemImages.mail.toSelected
    )
    private lazy var passwordTextField = CustomTextField(
        type: .password(secure: true),
        placeholderText: Localization.Authentication.password.text,
        image: AppConstants.SystemImages.key.toSelected
    )
    private lazy var confirmPasswordTextField = CustomTextField(
        type: .password(secure: true),
        placeholderText: Localization.Authentication.confirmPassword.text,
        image: AppConstants.SystemImages.key.toSelected
    )
    private lazy var signupButton = CustomButton(
        gradientColors: [.black, .blue],
        title: Localization.Authentication.signup.text
    )
    private lazy var haveAccountLabel = addLabel(
        text: Localization.Authentication.alreadyHaveAccount.text
    )
    private lazy var signinLabel = addLabel(
        isUnderlined: true,
        text: Localization.Authentication.login.text
    )
    
    /// Called after the controller's view is loaded into memory.
    /// Sets up the view's background color, notifies the presenter, and configures the UI.
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        presenter.viewDidLoad()
        setupUI()
    }

    /// Configures the UI elements, adds targets and gesture recognizers, and sets up constraints.
    private func setupUI() {
        signupButton.addTarget(self, action: #selector(signupTapped), for: .touchUpInside)
        signinLabel.addGestureRecognizer(for: #selector(signinLabelTapped), target: self)
        
        view.addSubviews(
            usernameTextField,
            emailTextField,
            passwordTextField,
            confirmPasswordTextField,
            signupButton,
            haveAccountLabel,
            signinLabel
        )
        
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: AppConstants.Spacing.extraLarge.rawValue
            ),
            usernameTextField.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: AppConstants.Spacing.medium.rawValue
            ),
            usernameTextField.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -AppConstants.Spacing.medium.rawValue
            ),
            usernameTextField.heightAnchor.constraint(
                equalToConstant: AppConstants.Spacing.extraLarge.rawValue
            ),
            
            emailTextField.topAnchor.constraint(
                equalTo: usernameTextField.bottomAnchor,
                constant: AppConstants.Spacing.medium.rawValue
            ),
            emailTextField.leadingAnchor.constraint(
                equalTo: usernameTextField.leadingAnchor
            ),
            emailTextField.trailingAnchor.constraint(
                equalTo: usernameTextField.trailingAnchor
            ),
            emailTextField.heightAnchor.constraint(
                equalToConstant: AppConstants.Spacing.extraLarge.rawValue
            ),
            
            passwordTextField.topAnchor.constraint(
                equalTo: emailTextField.bottomAnchor,
                constant: AppConstants.Spacing.medium.rawValue
            ),
            passwordTextField.leadingAnchor.constraint(
                equalTo: emailTextField.leadingAnchor
            ),
            passwordTextField.trailingAnchor.constraint(
                equalTo: emailTextField.trailingAnchor
            ),
            passwordTextField.heightAnchor.constraint(
                equalToConstant: AppConstants.Spacing.extraLarge.rawValue
            ),
            
            confirmPasswordTextField.topAnchor.constraint(
                equalTo: passwordTextField.bottomAnchor,
                constant: AppConstants.Spacing.medium.rawValue
            ),
            confirmPasswordTextField.leadingAnchor.constraint(
                equalTo: passwordTextField.leadingAnchor
            ),
            confirmPasswordTextField.trailingAnchor.constraint(
                equalTo: passwordTextField.trailingAnchor
            ),
            confirmPasswordTextField.heightAnchor.constraint(
                equalToConstant: AppConstants.Spacing.extraLarge.rawValue
            ),
            
            signupButton.topAnchor.constraint(
                equalTo: confirmPasswordTextField.bottomAnchor,
                constant: AppConstants.Spacing.large.rawValue
            ),
            signupButton.leadingAnchor.constraint(
                equalTo: confirmPasswordTextField.leadingAnchor
            ),
            signupButton.trailingAnchor.constraint(
                equalTo: confirmPasswordTextField.trailingAnchor
            ),
            signupButton.heightAnchor.constraint(
                equalToConstant: AppConstants.Spacing.extraLarge.rawValue
            ),
            
            signinLabel.topAnchor.constraint(
                equalTo: signupButton.bottomAnchor,
                constant: AppConstants.Spacing.medium.rawValue
            ),
            signinLabel.trailingAnchor.constraint(
                equalTo: signupButton.trailingAnchor
            ),
            
            haveAccountLabel.topAnchor.constraint(
                equalTo: signinLabel.topAnchor
            ),
            haveAccountLabel.trailingAnchor.constraint(
                equalTo: signinLabel.leadingAnchor,
                constant: -AppConstants.Spacing.small.rawValue
            )
        ])
    }

    /// Called when the signup button is tapped.
    /// Creates a SignupRequest and passes it to the presenter.
    @objc private func signupTapped() {
        let request = SignupRequest(
            username: usernameTextField.text ?? "",
            email: emailTextField.text ?? "",
            password: passwordTextField.text ?? "",
            confirmPassword: confirmPasswordTextField.text ?? ""
        )
        presenter.didTapSignupButton(with: request)
    }
    
    /// Called when the signin label is tapped.
    /// Notifies the presenter to handle the signin action.
    @objc private func signinLabelTapped() {
        presenter.didTapSigninButton()
    }
}
