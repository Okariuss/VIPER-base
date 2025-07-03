//
//  CGFloat+Extension.swift
//  iosBase
//
//  Created by Okan Orkun on 29.05.2025.
//

import UIKit

/// A CGFloat extension that provides access to the device screen width and height.
extension CGFloat {
    /// The width of the device's main screen.
    static let deviceWidth: CGFloat = UIScreen.main.bounds.width

    /// The height of the device's main screen.
    static let deviceHeight: CGFloat = UIScreen.main.bounds.height
}
