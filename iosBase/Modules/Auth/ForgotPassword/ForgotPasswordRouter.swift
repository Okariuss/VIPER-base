//
//  ForgotPasswordRouter.swift
//  iosBase
//
//  Created by Okan Orkun on 5.06.2025.
//

import UIKit

/// Routes for Forgot Password flow navigation.
enum ForgotPasswordRoute {
    case login
}

/// Protocol defining navigation actions for Forgot Password module.
protocol ForgotPasswordRouterProtocol: BaseRouterProtocol {
    /// Navigates asynchronously to a given route.
    /// - Parameter route: The destination route.
    @MainActor
    func navigate(to route: ForgotPasswordRoute) async
}

/// Router responsible for navigation in Forgot Password module.
final class ForgotPasswordRouter: BaseRouter, ForgotPasswordRouterProtocol {
    weak var viewController: UIViewController?

    /// Initializes the router with navigation controller and optional view controller.
    /// - Parameters:
    ///   - navigationController: The navigation controller to perform navigation.
    ///   - viewController: Optional current view controller.
    init(navigationController: UINavigationController?, viewController: UIViewController? = nil) {
        super.init(navigationController: navigationController)
        self.viewController = viewController
    }

    /// Performs navigation to a specified route asynchronously on the main thread.
    /// - Parameter route: The target route.
    @MainActor
    func navigate(to route: ForgotPasswordRoute) async {
        switch route {
        case .login:
            pop()
        }
    }
}
