//
//  SignupBuilder.swift
//  iosBase
//
//  Created by Okan Orkun on 29.05.2025.
//

import UIKit

/// Builder class responsible for constructing the Signup module components.
final class SignupBuilder: ModuleBuilder {

    /// Builds and returns the Signup module view controller with all dependencies configured.
    /// - Parameter navigationController: The navigation controller used for routing.
    /// - Returns: Configured `SignupViewController` instance.
    static func build(navigationController: UINavigationController?) -> UIViewController {
        let container = DIContainer.shared.container
        guard let view = container.resolve(SignupViewController.self),
              let interactor = container.resolve(SignupInteractorProtocol.self) else {
            fatalError("Dependency injection failed for Signup module")
        }
        let router = SignupRouter(navigationController: navigationController, viewController: view)
        let presenter = SignupPresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        return view
    }
}
