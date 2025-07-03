//
//  HomeBuilder.swift
//  iosBase
//
//  Created by Okan Orkun on 29.05.2025.
//

import UIKit

/// Builder class responsible for constructing the Home module components.
final class HomeBuilder: ModuleBuilder {

    /// Builds and returns the Home module view controller with all dependencies configured.
    /// - Parameter navigationController: The navigation controller used for routing.
    /// - Returns: Configured `HomeViewController` instance.
    static func build(navigationController: UINavigationController?) -> UIViewController {
        let container = DIContainer.shared.container
        guard let view = container.resolve(HomeViewController.self),
              let interactor = container.resolve(HomeInteractorProtocol.self) else {
            fatalError("Dependency injection failed for Home module")
        }
        let router = HomeRouter(navigationController: navigationController, viewController: view)
        let presenter = HomePresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        return view
    }
}
