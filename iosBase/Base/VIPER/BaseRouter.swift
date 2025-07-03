//
//  BaseRouter.swift
//  iosBase
//
//  Created by Okan Orkun on 29.05.2025.
//

import UIKit

/// Base protocol to define router structure.
@MainActor
protocol BaseRouterProtocol: AnyObject {
    var navigationController: UINavigationController? { get set }
}

/// A base class responsible for routing/navigation between view controllers.
@MainActor
class BaseRouter: BaseRouterProtocol {
    weak var navigationController: UINavigationController?

    init(navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController
    }

    /// Sets the view controllers stack on the navigation controller.
    func setViewControllers<T: UIViewController>(with viewControllers: [T], animated: Bool = true) {
        DispatchQueue.main.async {
            self.navigationController?.setViewControllers(viewControllers, animated: animated)
        }
    }

    /// Pushes a view controller onto the navigation stack.
    func push<T: UIViewController>(to viewController: T, animated: Bool = true) {
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(viewController, animated: animated)
        }
    }

    /// Presents a view controller modally.
    func present<T: UIViewController>(_ viewController: T, animated: Bool = true, completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            self.navigationController?.present(viewController, animated: animated, completion: completion)
        }
    }

    /// Pops the top view controller from the navigation stack.
    func pop(animated: Bool = true) {
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: animated)
        }
    }

    /// Pops all the view controllers on the stack until the root view controller is at the top.
    func popToRoot(animated: Bool = true) {
        DispatchQueue.main.async {
            self.navigationController?.popToRootViewController(animated: animated)
        }
    }
}
