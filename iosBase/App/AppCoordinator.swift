//
//  AppCoordinator.swift
//  iosBase
//
//  Created by Okan Orkun on 29.05.2025.
//

import UIKit

final class AppCoordinator {
    private let window: UIWindow
    private(set) var navigationController: UINavigationController?

    init(window: UIWindow) {
        self.window = window
    }

    /// Starts the app flow by determining and setting the initial root view controller
    @MainActor
    func start() {
        let session = SessionManager.shared
        session.performFirstInstallCheck()
        let navController = UINavigationController()
        navigationController = navController
        let rootVC: UIViewController
        switch (session.isOnboardingSeen, session.isLoggedIn) {
        case (false, _):
            rootVC = OnboardingBuilder.build(navigationController: navController)
        case (true, false):
            rootVC = LoginBuilder.build(navigationController: navController)
        case (true, true):
            rootVC = HomeBuilder.build(navigationController: navController)
        }
        navController.viewControllers = [rootVC]
        window.rootViewController = navController
        window.makeKeyAndVisible()
    }
}
