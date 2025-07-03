//
//  ForgotPasswordViewController.swift
//  iosBase
//
//  Created by Okan Orkun on 5.06.2025.
//

import UIKit

/// View controller responsible for the Forgot Password screen.
class ForgotPasswordViewController: BaseViewController {
    var presenter: ForgotPasswordPresenterProtocol!
    
    private lazy var forgotPasswordTextField = CustomTextField(
        type: .email,
        placeholderText: Localization.Authentication.email.text,
        image: AppConstants.SystemImages.mail.toSelected
    )
    
    private lazy var forgotPasswordButton = CustomButton(
        gradientColors: [.black, .blue],
        title: Localization.Authentication.forgotPassword.text
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        presenter.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordTapped), for: .touchUpInside)
        
        view.addSubviews(forgotPasswordTextField, forgotPasswordButton)
        NSLayoutConstraint.activate([
            forgotPasswordTextField.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: AppConstants.Spacing.extraLarge.rawValue
            ),
            forgotPasswordTextField.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: AppConstants.Spacing.medium.rawValue
            ),
            forgotPasswordTextField.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -AppConstants.Spacing.medium.rawValue
            ),
            forgotPasswordTextField.heightAnchor.constraint(
                equalToConstant: AppConstants.Spacing.extraLarge.rawValue
            ),
            
            forgotPasswordButton.topAnchor.constraint(
                equalTo: forgotPasswordTextField.bottomAnchor,
                constant: AppConstants.Spacing.large.rawValue
            ),
            forgotPasswordButton.leadingAnchor.constraint(
                equalTo: forgotPasswordTextField.leadingAnchor
            ),
            forgotPasswordButton.trailingAnchor.constraint(
                equalTo: forgotPasswordTextField.trailingAnchor
            ),
            forgotPasswordButton.heightAnchor.constraint(
                equalToConstant: AppConstants.Spacing.extraLarge.rawValue
            )
        ])
    }
    
    /// Called when the forgot password button is tapped.
    /// Creates a forgot password request and notifies the presenter.
    @objc private func forgotPasswordTapped() {
        let request = ForgotPasswordRequest(email: forgotPasswordTextField.text ?? "")
        presenter.didTapForgotPasswordButton(with: request)
    }
}
