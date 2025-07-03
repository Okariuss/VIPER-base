//
//  LoginBuilder.swift
//  iosBase
//
//  Created by Okan Orkun on 29.05.2025.
//

import UIKit

/// Builder class responsible for constructing the Login module components.
final class LoginBuilder: ModuleBuilder {

    /// Builds and returns the Login module view controller with all dependencies configured.
    /// - Parameter navigationController: The navigation controller used for routing.
    /// - Returns: Configured `LoginViewController` instance.
    static func build(navigationController: UINavigationController?) -> UIViewController {
        let container = DIContainer.shared.container
        guard let view = container.resolve(LoginViewController.self),
              let interactor = container.resolve(LoginInteractorProtocol.self) else {
            fatalError("Dependency injection failed for Login module")
        }
        let router = LoginRouter(navigationController: navigationController, viewController: view)
        let presenter = LoginPresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        return view
    }
}
