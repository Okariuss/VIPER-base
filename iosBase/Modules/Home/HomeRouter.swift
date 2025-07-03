//
//  HomeRouter.swift
//  iosBase
//
//  Created by Okan Orkun on 29.05.2025.
//

import UIKit

/// Enum representing possible navigation routes from the Home module.
enum HomeRoute {
    // Define future routes here
}

/// Protocol defining navigation actions for the Home module.
protocol HomeRouterProtocol: BaseRouterProtocol {
    /// Navigates asynchronously to a specified route.
    /// - Parameter route: The route to navigate to.
    @MainActor
    func navigate(to route: HomeRoute) async
}

/// Router responsible for handling navigation within the Home module.
final class HomeRouter: BaseRouter, HomeRouterProtocol {
    weak var viewController: UIViewController?

    /// Initializes the router with navigation controller and optional view controller.
    /// - Parameters:
    ///   - navigationController: The UINavigationController used for navigation.
    ///   - viewController: The current UIViewController.
    init(navigationController: UINavigationController?, viewController: UIViewController?) {
        super.init(navigationController: navigationController)
        self.viewController = viewController
    }

    /// Performs navigation asynchronously to the specified route.
    /// - Parameter route: The target route.
    @MainActor
    func navigate(to route: HomeRoute) async {
        switch route {
        // Handle routes here in the future
        }
    }
}
