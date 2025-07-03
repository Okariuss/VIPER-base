//
//  ValidationManager.swift
//  iosBase
//
//  Created by Okan Orkun on 7.06.2025.
//

import Foundation

/// Defines validation errors that can occur during authentication.
enum ValidationError: Error, LocalizedError {
    case emptyField(String)
    case invalidEmail
    case invalidPassword
    case passwordsDoNotMatch

    var errorDescription: String? {
        switch self {
        case .emptyField(let field):
            return "\(field) \(Localization.Authentication.emptyField.text)"
        case .invalidEmail:
            return Localization.Authentication.invalidEmail.text
        case .invalidPassword:
            return Localization.Authentication.invalidPassword.text
        case .passwordsDoNotMatch:
            return Localization.Authentication.passwordsDontMatch.text
        }
    }
}

/// Protocol defining methods for validating authentication-related requests.
protocol ValidationManager {
    /// Validates the signup request.
    /// - Parameter request: SignupRequest object to validate.
    /// - Throws: ValidationError if validation fails.
    func validateSignup(request: SignupRequest) throws

    /// Validates the login request.
    /// - Parameter request: LoginRequest object to validate.
    /// - Throws: ValidationError if validation fails.
    func validateLogin(request: LoginRequest) throws

    /// Validates the forgot password email request.
    /// - Parameter request: ForgotPasswordRequest object to validate.
    /// - Throws: ValidationError if validation fails.
    func validateEmail(request: ForgotPasswordRequest) throws

    /// Checks if the given email string is valid.
    /// - Parameter email: Email string to validate.
    /// - Returns: True if email is valid, false otherwise.
    func isValidEmail(email: String) -> Bool

    /// Checks if the given password string is valid.
    /// - Parameter password: Password string to validate.
    /// - Returns: True if password is valid, false otherwise.
    func isValidPassword(password: String) -> Bool
}

extension ValidationManager {
    func isValidEmail(email: String) -> Bool {
        let email = email.trimmingCharacters(in: .whitespacesAndNewlines)
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }

    func isValidPassword(password: String) -> Bool {
        let password = password.trimmingCharacters(in: .whitespacesAndNewlines)
        let passwordRegex = "(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[^\\w\\s]).{8,}"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
    }

    func validateSignup(request: SignupRequest) throws {
        if request.username.trimmingCharacters(in: .whitespaces).isEmpty {
            throw ValidationError.emptyField(Localization.Authentication.name.text)
        }
        if request.email.trimmingCharacters(in: .whitespaces).isEmpty {
            throw ValidationError.emptyField(Localization.Authentication.email.text)
        }
        if !isValidEmail(email: request.email) {
            throw ValidationError.invalidEmail
        }
        if request.password.isEmpty || request.confirmPassword.isEmpty {
            throw ValidationError.emptyField(Localization.Authentication.password.text)
        }
        if !isValidPassword(password: request.password) {
            throw ValidationError.invalidPassword
        }
        if request.password != request.confirmPassword {
            throw ValidationError.passwordsDoNotMatch
        }
    }

    func validateLogin(request: LoginRequest) throws {
        if request.email.trimmingCharacters(in: .whitespaces).isEmpty {
            throw ValidationError.emptyField(Localization.Authentication.email.text)
        }
        if !isValidEmail(email: request.email) {
            throw ValidationError.invalidEmail
        }
        if request.password.isEmpty {
            throw ValidationError.emptyField(Localization.Authentication.password.text)
        }
        if !isValidPassword(password: request.password) {
            throw ValidationError.invalidPassword
        }
    }

    func validateEmail(request: ForgotPasswordRequest) throws {
        if request.email.trimmingCharacters(in: .whitespaces).isEmpty {
            throw ValidationError.emptyField(Localization.Authentication.email.text)
        }
        if !isValidEmail(email: request.email) {
            throw ValidationError.invalidEmail
        }
    }
}
