//
//  LoginViewController.swift
//  iosBase
//
//  Created by Okan Orkun on 29.05.2025.
//

import UIKit

/// View controller responsible for the Login screen UI and user interactions.
class LoginViewController: BaseViewController {
    var presenter: LoginPresenterProtocol!

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
    
    private lazy var forgotPasswordLabel = addLabel(isUnderlined: true, text: Localization.Authentication.forgotPassword.text)
    
    private lazy var loginButton = CustomButton(
        gradientColors: [.black, .blue],
        title: Localization.Authentication.login.text
    )
    
    private lazy var dontHaveAccountLabel = addLabel(text: Localization.Authentication.noAccount.text)
    
    private lazy var signUpLabel = addLabel(isUnderlined: true, text: Localization.Authentication.signup.text)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        presenter.viewDidLoad()
        setupUI()
    }

    /// Sets up UI elements and constraints.
    private func setupUI() {
        // Add gesture recognizers for tappable labels
        forgotPasswordLabel.addGestureRecognizer(for: #selector(forgotPasswordTapped), target: self)
        signUpLabel.addGestureRecognizer(for: #selector(signupTapped), target: self)
        // Add target for login button tap
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)

        // Add subviews to the main view
        view.addSubviews(emailTextField, passwordTextField, forgotPasswordLabel, loginButton, dontHaveAccountLabel, signUpLabel)

        // Activate layout constraints
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: AppConstants.Spacing.extraLarge.rawValue
            ),
            emailTextField.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: AppConstants.Spacing.medium.rawValue
            ),
            emailTextField.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -AppConstants.Spacing.medium.rawValue
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
            
            forgotPasswordLabel.topAnchor.constraint(
                equalTo: passwordTextField.bottomAnchor,
                constant: AppConstants.Spacing.medium.rawValue
            ),
            forgotPasswordLabel.trailingAnchor.constraint(
                equalTo: passwordTextField.trailingAnchor
            ),
            
            loginButton.topAnchor.constraint(
                equalTo: forgotPasswordLabel.bottomAnchor,
                constant: AppConstants.Spacing.large.rawValue
            ),
            loginButton.leadingAnchor.constraint(
                equalTo: emailTextField.leadingAnchor
            ),
            loginButton.trailingAnchor.constraint(
                equalTo: emailTextField.trailingAnchor
            ),
            loginButton.heightAnchor.constraint(
                equalToConstant: AppConstants.Spacing.extraLarge.rawValue
            ),
            
            signUpLabel.topAnchor.constraint(
                equalTo: loginButton.bottomAnchor,
                constant: AppConstants.Spacing.medium.rawValue
            ),
            signUpLabel.trailingAnchor.constraint(
                equalTo: forgotPasswordLabel.trailingAnchor
            ),
            
            dontHaveAccountLabel.topAnchor.constraint(
                equalTo: loginButton.bottomAnchor,
                constant: AppConstants.Spacing.medium.rawValue
            ),
            dontHaveAccountLabel.trailingAnchor.constraint(
                equalTo: signUpLabel.leadingAnchor,
                constant: -AppConstants.Spacing.small.rawValue
            ),
        ])
    }
    
    /// Action called when the forgot password label is tapped.
    @objc private func forgotPasswordTapped() {
        presenter.didTapForgotPasswordButton()
    }
    
    /// Action called when the sign up label is tapped.
    @objc private func signupTapped() {
        presenter.didTapSignUpButton()
    }

    /// Action called when the login button is tapped.
    @objc private func loginTapped() {
        let request = LoginRequest(email: emailTextField.text ?? "", password: passwordTextField.text ?? "")
        presenter.didTapLoginButton(with: request)
    }
}
