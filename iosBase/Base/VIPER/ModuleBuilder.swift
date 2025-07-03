//
//  ModuleBuilder.swift
//  iosBase
//
//  Created by Okan Orkun on 29.05.2025.
//

import UIKit

@MainActor
protocol ModuleBuilder {
    static func build(navigationController: UINavigationController?) -> UIViewController
}
