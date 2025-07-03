//
//  Colors.swift
//  iosBase
//
//  Created by Okan Orkun on 29.05.2025.
//

import UIKit

/// Struct encapsulating application color constants.
struct AppColors {
    let color: UIColor
    
    /// Primary color used for main elements.
    static let primary = AppColors(color: .systemBlue)
    
    /// Secondary color used for accents and highlights.
    static let secondary = AppColors(color: .systemTeal)
    
    /// Background color used for general UI backgrounds.
    static let background = AppColors(color: .systemBackground)
    
    /// Primary text color used for main readable text.
    static let textPrimary = AppColors(color: .label)
    
    /// Secondary text color used for less prominent text.
    static let textSecondary = AppColors(color: .secondaryLabel)
}
