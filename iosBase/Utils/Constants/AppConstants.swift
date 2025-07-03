//
//  AppConstants.swift
//  iosBase
//
//  Created by Okan Orkun on 29.05.2025.
//

import Foundation
import UIKit

/// Centralized constants used throughout the app.
final class AppConstants {
    private init() { }

    /// System images used in UI components.
    enum SystemImages {
        case next, back, down, up, mail, key, showPassword, hidePassword, card, gender

        /// The raw string value representing the system image name.
        var rawValue: String {
            switch self {
            case .next:
                return "chevron.right"
            case .back:
                return "chevron.left"
            case .down:
                return "chevron.down"
            case .up:
                return "chevron.up"
            case .mail:
                return "envelope"
            case .key:
                return "key.horizontal"
            case .showPassword:
                return "eye"
            case .hidePassword:
                return "eye.slash"
            case .card:
                return "person.text.rectangle"
            case .gender:
                return "figure.dress.line.vertical.figure"
            }
        }

        /// The filled variant of the system image.
        var toSelected: UIImage {
            UIImage(systemName: "\(rawValue).fill") ?? UIImage()
        }

        /// The normal variant of the system image.
        var normal: UIImage {
            UIImage(systemName: rawValue) ?? UIImage()
        }
    }

    /// Custom image assets used in the app.
    enum Images {
        case appImage, onboard1, onboard2, onboard3

        /// The raw string value representing the image asset name.
        var rawValue: String {
            switch self {
            case .appImage:
                return "app_image"
            case .onboard1:
                return "onboard1"
            case .onboard2:
                return "onboard2"
            case .onboard3:
                return "onboard3"
            }
        }

        /// Returns the UIImage for the asset.
        var toImage: UIImage {
            UIImage(named: "img_\(rawValue)") ?? UIImage()
        }
    }

    /// Standard font sizes used throughout the app.
    enum FontSize {
        // Title font sizes
        case extraLargeTitle, largeTitle, title, mediumTitle
        // Body font sizes
        case body, caption
        // Small font sizes
        case small, extraSmall

        /// Returns the CGFloat value for font size.
        var rawValue: CGFloat {
            switch self {
            case .extraLargeTitle:
                return 48
            case .largeTitle:
                return 24
            case .title:
                return 16
            case .mediumTitle:
                return 14
            case .body:
                return 12
            case .caption:
                return 10
            case .small:
                return 8
            case .extraSmall:
                return 6
            }
        }

        /// Returns the UIFont instance for the size.
        var toFont: UIFont {
            .systemFont(ofSize: rawValue)
        }
    }

    /// Standard spacing values used for layout.
    enum Spacing {
        case small, medium, large, extraLarge

        /// Returns the CGFloat value for spacing.
        var rawValue: CGFloat {
            switch self {
            case .small:
                return 8
            case .medium:
                return 16
            case .large:
                return 24
            case .extraLarge:
                return 32
            }
        }
    }

    /// Standard image sizes used in UI.
    enum ImageSize {
        case small, medium, large, extraLarge, big, xxLarge

        /// Returns the CGFloat value for image size.
        var rawValue: CGFloat {
            switch self {
            case .small:
                return 24
            case .medium:
                return 48
            case .large:
                return 96
            case .extraLarge:
                return 128
            case .big:
                return 192
            case .xxLarge:
                return 256
            }
        }
    }

    /// UserDefaults keys used in the app.
    enum UserDefaultsEnums {
        case isFirst, isLogin

        /// Returns the key string for UserDefaults.
        var rawValue: String {
            switch self {
            case .isFirst:
                return "isFirst"
            case .isLogin:
                return "isLogin"
            }
        }
    }

    /// TextField height presets.
    enum TextFieldHeight {
        case small, medium, large, xLarge, xxLarge

        /// Returns the CGFloat value for height.
        var rawValue: CGFloat {
            switch self {
            case .small:
                return 40
            case .medium:
                return 60
            case .large:
                return 80
            case .xLarge:
                return 120
            case .xxLarge:
                return 160
            }
        }
    }

    /// Core Data entity names.
    enum Entities {
        case userEntity

        /// Returns the entity name string.
        var rawValue: String {
            switch self {
            case .userEntity:
                return "UserEntity"
            }
        }
    }

    /// Core Data collection names.
    enum Collections {
        case users

        /// Returns the collection name string.
        var rawValue: String {
            switch self {
            case .users:
                return "Users"
            }
        }
    }
}

