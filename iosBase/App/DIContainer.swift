//
//  DIContainer.swift
//  iosBase
//
//  Created by Okan Orkun on 11.06.2025.
//

import Swinject
import UIKit

final class DIContainer {
    static let shared = DIContainer()
    let container = Container()
    
    private init() {
        registerDependencies()
    }
    
    private func registerDependencies() {
        registerManagers()
        registerLoginModule()
        registerSignupModule()
        registerForgotPasswordModule()
        registerOnboardingModule()
        registerHomeModule()
    }
}

// MARK: - Shared Managers

private extension DIContainer {
    func registerManagers() {
        container.register(AuthenticationManagerProtocol.self) { _ in
            AuthenticationManager.shared
        }
        
        container.register(SessionManagerProtocol.self) { _ in
            SessionManager.shared
        }
    }
}

// MARK: - Login Module

private extension DIContainer {
    func registerLoginModule() {
        container.register(LoginInteractorProtocol.self) { resolver in
            guard let authManager = resolver.resolve(AuthenticationManagerProtocol.self),
                  let sessionManager = resolver.resolve(SessionManagerProtocol.self) else {
                fatalError("Dependency injection failed for LoginInteractor")
            }
            return LoginInteractor(authManager: authManager, sessionManager: sessionManager)
        }
        
        container.register(LoginViewController.self) { _ in
            LoginViewController()
        }
    }
}

// MARK: - Signup Module

private extension DIContainer {
    func registerSignupModule() {
        container.register(SignupInteractorProtocol.self) { resolver in
            guard let authManager = resolver.resolve(AuthenticationManagerProtocol.self),
                  let sessionManager = resolver.resolve(SessionManagerProtocol.self) else {
                fatalError("Dependency injection failed for SignupInteractor")
            }
            return SignupInteractor(authManager: authManager, sessionManager: sessionManager)
        }
        
        container.register(SignupViewController.self) { _ in
            SignupViewController()
        }
    }
}

// MARK: - Forgot Password Module

private extension DIContainer {
    func registerForgotPasswordModule() {
        container.register(ForgotPasswordInteractorProtocol.self) { resolver in
            guard let authManager = resolver.resolve(AuthenticationManagerProtocol.self) else {
                fatalError("Dependency injection failed for ForgotPasswordInteractor")
            }
            return ForgotPasswordInteractor(authManager: authManager)
        }
        
        container.register(ForgotPasswordViewController.self) { _ in
            ForgotPasswordViewController()
        }
    }
}

// MARK: - Onboarding Module

private extension DIContainer {
    func registerOnboardingModule() {
        container.register(OnboardingInteractorProtocol.self) { resolver in
            guard let sessionManager = resolver.resolve(SessionManagerProtocol.self) else {
                fatalError("Dependency injection failed for OnboardingInteractor")
            }
            return OnboardingInteractor(sessionManager: sessionManager)
        }
        
        container.register(OnboardingViewController.self) { _ in
            OnboardingViewController()
        }
    }
}

// MARK: - Home Module

private extension DIContainer {
    func registerHomeModule() {
        container.register(HomeInteractorProtocol.self) { _ in
            HomeInteractor()
        }
        
        container.register(HomeViewController.self) { _ in
            HomeViewController()
        }
    }
}
