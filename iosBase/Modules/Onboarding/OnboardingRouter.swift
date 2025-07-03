//
//  OnboardingRouter.swift
//  iosBase
//
//  Created by Okan Orkun on 29.05.2025.
//

import UIKit

/// Defines navigation routes for the Onboarding module.
enum OnboardingRoute {
    case home
    case login
}

/// Protocol defining navigation actions for the Onboarding module.
protocol OnboardingRouterProtocol: BaseRouterProtocol {
    /// Navigates asynchronously to the specified route.
    /// - Parameter route: The route to navigate to.
    @MainActor
    func navigate(to route: OnboardingRoute) async
}

/// Router responsible for navigation within the Onboarding module.
final class OnboardingRouter: BaseRouter, OnboardingRouterProtocol {
    weak var viewController: UIViewController?

    /// Initializes the router with a navigation controller and optional view controller.
    /// - Parameters:
    ///   - navigationController: The UINavigationController used for navigation.
    ///   - viewController: The current UIViewController instance.
    init(navigationController: UINavigationController?, viewController: UIViewController?) {
        super.init(navigationController: navigationController)
        self.viewController = viewController
    }

    /// Performs navigation asynchronously on the main thread to the specified route.
    /// - Parameter route: The target route.
    @MainActor
    func navigate(to route: OnboardingRoute) async {
        switch route {
        case .home:
            let homeVC = HomeBuilder.build(navigationController: navigationController)
            setViewControllers(with: [homeVC])
        case .login:
            let loginVC = LoginBuilder.build(navigationController: navigationController)
            setViewControllers(with: [loginVC])
        }
    }
}
