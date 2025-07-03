//
//  ForgotPasswordBuilder.swift
//  iosBase
//
//  Created by Okan Orkun on 5.06.2025.
//

import UIKit

final class ForgotPasswordBuilder: ModuleBuilder {
    
    /// Builds and returns the Login module view controller with all dependencies configured.
    /// - Parameter navigationController: The navigation controller used for routing.
    /// - Returns: Configured `ForgotPasswordViewController` instance..
    @MainActor
    static func build(navigationController: UINavigationController?) -> UIViewController {
        let container = DIContainer.shared.container
        guard let view = container.resolve(ForgotPasswordViewController.self),
              let interactor = container.resolve(ForgotPasswordInteractorProtocol.self) else {
            fatalError("Dependency injection failed for ForgotPassword module")
        }
        let router = ForgotPasswordRouter(navigationController: navigationController, viewController: view)
        let presenter = ForgotPasswordPresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        return view
    }
}
