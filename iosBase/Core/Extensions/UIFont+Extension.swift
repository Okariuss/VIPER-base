//
//  UIFont+Extension.swift
//  iosBase
//
//  Created by Okan Orkun on 29.05.2025.
//

import UIKit

extension UIFont {
    /// Returns a bold version of the current font, if available.
    var boldVersion: UIFont {
        guard let descriptor = fontDescriptor.withSymbolicTraits(.traitBold) else {
            return self
        }
        return UIFont(descriptor: descriptor, size: 0)
    }

    /// Returns an italic version of the current font, if available.
    var italicVersion: UIFont {
        guard let descriptor = fontDescriptor.withSymbolicTraits(.traitItalic) else {
            return self
        }
        return UIFont(descriptor: descriptor, size: 0)
    }
}
