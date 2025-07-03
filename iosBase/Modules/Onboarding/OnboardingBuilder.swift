//
//  OnboardingBuilder.swift
//  iosBase
//
//  Created by Okan Orkun on 29.05.2025.
//

import UIKit

/// Builder class responsible for constructing the Onboarding module components.
final class OnboardingBuilder: ModuleBuilder {
    
    /// Builds and returns the Onboarding module view controller with all dependencies configured.
    /// - Parameter navigationController: The navigation controller used for routing.
    /// - Returns: Configured `OnboardingViewController` instance.
    static func build(navigationController: UINavigationController?) -> UIViewController {
        let container = DIContainer.shared.container
        guard
            let view = container.resolve(OnboardingViewController.self),
            let interactor = container.resolve(OnboardingInteractorProtocol.self)
        else {
            fatalError("Dependency injection failed for Onboarding module")
        }
        let router = OnboardingRouter(navigationController: navigationController, viewController: view)
        let presenter = OnboardingPresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        return view
    }
}
