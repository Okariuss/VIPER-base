//
//  Localization.swift
//  iosBase
//
//  Created by Okan Orkun on 29.05.2025.
//

import Foundation

protocol LocalizationProtocol: RawRepresentable where RawValue == String { }

extension LocalizationProtocol {
    var text: String {
        rawValue.localized
    }
}

final class Localization {
    private init() { }

    // MARK: - Common
    enum Common: String, LocalizationProtocol {
        case ok = "common_ok"
        case cancel = "common_cancel"
        case error = "common_error"
        case success = "common_success"
        case warning = "common_warning"
        case next = "common_next"
        case back = "common_back"
        case skip = "common_skip"
        case getStarted = "common_get_started"
    }

    // MARK: - Authentication
    enum Authentication: String, LocalizationProtocol {
        case login = "authentication_login"
        case loginTitle = "authentication_login_title"
        case signup = "authentication_signup"
        case signupTitle = "authentication_signup_title"
        case name = "authentication_name"
        case email = "authentication_email"
        case password = "authentication_password"
        case confirmPassword = "authentication_confirm_password"
        case forgotPassword = "authentication_forgot_password"
        case forgotPasswordText = "authentication_forgot_password_text"
        case noAccount = "authentication_no_account_signup"
        case alreadyHaveAccount = "authentication_have_account_login"
        case logout = "authentication_logout"
        case emptyField = "authentication_empty_fields"
        case invalidEmail = "authentication_invalid_email"
        case invalidPassword = "authentication_invalid_password"
        case passwordsDontMatch = "authentication_passwords_dont_match"
    }

    // MARK: - Home
    enum Home: String, LocalizationProtocol {
        case home = "home_title"
        case welcome = "home_welcome"
        case settings = "home_settings"
        case profile = "home_profile"
    }

    // MARK: - Onboarding
    enum Onboarding: String, LocalizationProtocol {
        case skip = "onboarding_skip"
        case next = "onboarding_next"
        case getStarted = "onboarding_get_started"
        case welcomeTitle = "onboarding_welcome_title"
        case welcomeDescription = "onboarding_welcome_description"
        case featuresTitle = "onboarding_features_title"
        case featuresDescription1 = "onboarding_features_description"
        case readyTitle = "onboarding_ready_title"
        case readyDescription = "onboarding_ready_description"
    }

    // MARK: - Validation
    enum Validation: String, LocalizationProtocol {
        case enterCredentials = "validation_enter_credentials"
        case fillAllFields = "validation_fill_all_fields"
        case invalidCredentials = "validation_invalid_credentials"
        case passwordDoesNotMatch = "validation_passwords_does_not_match"
        case invalidSignupData = "validation_invalid_signup_data"
        case unknownError = "validation_unknown_error"
    }
}
