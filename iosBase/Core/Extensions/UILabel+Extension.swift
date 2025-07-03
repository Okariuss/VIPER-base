//
//  UILabel+Extension.swift
//  iosBase
//
//  Created by Okan Orkun on 29.05.2025.
//

import UIKit

extension UILabel {
    /// Adds a UITapGestureRecognizer to the label with a specified action and target.
    /// - Parameters:
    ///   - action: The selector to be called when the label is tapped.
    ///   - target: The object that implements the action method.
    func addGestureRecognizer(for action: Selector, target: Any) {
        isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: target, action: action)
        addGestureRecognizer(tapGesture)
    }

    /// A computed property to get or set underlined text on the label.
    var underlinedText: String? {
        get {
            attributedText?.string
        }
        set {
            guard let newValue = newValue else {
                attributedText = nil
                return
            }
            let attributedString = NSMutableAttributedString(string: newValue)
            attributedString.addAttribute(
                .underlineStyle,
                value: NSUnderlineStyle.single.rawValue,
                range: NSRange(location: 0, length: attributedString.length)
            )
            attributedText = attributedString
        }
    }
}
