//
//  UIView+Extension.swift
//  iosBase
//
//  Created by Okan Orkun on 29.05.2025.
//

import UIKit

extension UIView {
    /// Adds multiple subviews to the view and disables autoresizing mask translation for each.
    /// - Parameter subviews: A variadic list of UIView instances to be added.
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}
