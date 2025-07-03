//
//  LoginRouter.swift
//  iosBase
//
//  Created by Okan Orkun on 29.05.2025.
//

// LoginRouter.swift

import UIKit

/// Defines the possible navigation routes from the Login module.
enum LoginRoute {
    case home
    case signup
    case forgotPassword
}

/// Protocol defining navigation actions from the Login module.
protocol LoginRouterProtocol: BaseRouterProtocol {
    /// Navigates asynchronously to a specified route.
    /// - Parameter route: The route to navigate to.
    @MainActor
    func navigate(to route: LoginRoute)
}

/// Router responsible for handling navigation from the Login module.
final class LoginRouter: BaseRouter, LoginRouterProtocol {
    weak var viewController: UIViewController?

    /// Initializes the router with a navigation controller and an optional view controller.
    /// - Parameters:
    ///   - navigationController: The UINavigationController used for navigation.
    ///   - viewController: The current UIViewController instance.
    init(navigationController: UINavigationController?, viewController: UIViewController?) {
        super.init(navigationController: navigationController)
        self.viewController = viewController
    }

    /// Performs navigation asynchronously to the specified route.
    /// - Parameter route: The target route.
    @MainActor
    func navigate(to route: LoginRoute) {
        switch route {
        case .home:
            let homeVC = HomeBuilder.build(navigationController: navigationController)
            setViewControllers(with: [homeVC])
        case .signup:
            let signupVC = SignupBuilder.build(navigationController: navigationController)
            push(to: signupVC)
        case .forgotPassword:
            let forgotPasswordVC = ForgotPasswordBuilder.build(navigationController: navigationController)
            push(to: forgotPasswordVC)
        }
    }
}
