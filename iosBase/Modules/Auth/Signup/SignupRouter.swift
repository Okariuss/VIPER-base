//
//  SignupRouter.swift
//  iosBase
//
//  Created by Okan Orkun on 29.05.2025.
//

import UIKit

enum SignupRoute {
    case home
    case signin
}

protocol SignupRouterProtocol: BaseRouterProtocol {
    @MainActor
    func navigate(to route: SignupRoute) async
}

final class SignupRouter: BaseRouter, SignupRouterProtocol {
    weak var viewController: UIViewController?
    
    init(navigationController: UINavigationController?, viewController: UIViewController?) {
        super.init(navigationController: navigationController)
        self.viewController = viewController
    }
    
    @MainActor
    func navigate(to route: SignupRoute) async {
        switch route {
        case .home:
            let homeVC = HomeBuilder.build(navigationController: navigationController)
            setViewControllers(with: [homeVC])
        case .signin:
            pop()
        }
    }
}
