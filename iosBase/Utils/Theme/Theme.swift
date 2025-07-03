//
//  Theme.swift
//  iosBase
//
//  Created by Okan Orkun on 29.05.2025.
//

import Foundation
import UIKit

/// Struct representing fonts used throughout the app's theme.
struct ThemeFont {
    let extraLargeFont: UIFont
    let largeTitleFont: UIFont
    let titleFont: UIFont
    let mediumTitleFont: UIFont
    let bodyFont: UIFont
    let captionFont: UIFont
    let smallFont: UIFont
    let extraSmallFont: UIFont
}

/// Struct representing the app's theme, containing fonts and potentially other style properties.
struct Theme {
    let themeFont: ThemeFont
}

extension Theme {
    
    /// Returns the default theme with optional custom font name.
    /// - Parameter fontName: Optional custom font name to use.
    /// - Returns: A configured `Theme` instance with specified fonts.
    static func defaultTheme(_ fontName: String? = nil) -> Theme {
        if let fontName {
            return Theme(
                themeFont: ThemeFont(
                    extraLargeFont: UIFont(name: fontName, size: AppConstants.FontSize.extraLargeTitle.rawValue)!.boldVersion,
                    largeTitleFont: UIFont(name: fontName, size: AppConstants.FontSize.largeTitle.rawValue)!.boldVersion,
                    titleFont: UIFont(name: fontName, size: AppConstants.FontSize.title.rawValue)!.boldVersion,
                    mediumTitleFont: UIFont(name: fontName, size: AppConstants.FontSize.mediumTitle.rawValue)!.boldVersion,
                    bodyFont: UIFont(name: fontName, size: AppConstants.FontSize.body.rawValue)!,
                    captionFont: UIFont(name: fontName, size: AppConstants.FontSize.caption.rawValue)!,
                    smallFont: UIFont(name: fontName, size: AppConstants.FontSize.small.rawValue)!,
                    extraSmallFont: UIFont(name: fontName, size: AppConstants.FontSize.extraSmall.rawValue)!
                )
            )
        }
        return Theme(
            themeFont: ThemeFont(
                extraLargeFont: AppConstants.FontSize.extraLargeTitle.toFont.boldVersion,
                largeTitleFont: AppConstants.FontSize.largeTitle.toFont.boldVersion,
                titleFont: AppConstants.FontSize.title.toFont.boldVersion,
                mediumTitleFont: AppConstants.FontSize.mediumTitle.toFont.boldVersion,
                bodyFont: AppConstants.FontSize.body.toFont,
                captionFont: AppConstants.FontSize.caption.toFont,
                smallFont: AppConstants.FontSize.small.toFont,
                extraSmallFont: AppConstants.FontSize.extraSmall.toFont
            )
        )
    }
}
