//
//  OnboardingEntity.swift
//  iosBase
//
//  Created by Okan Orkun on 29.05.2025.
//

import UIKit

/// Represents an onboarding screen item with title, description, and image.
struct OnboardingEntity {
    let title: String
    let description: String
    let image: UIImage

    /// Initializes an onboarding entity with localized text and image.
    /// - Parameters:
    ///   - title: The localized title.
    ///   - description: The localized description.
    ///   - image: The associated image asset.
    init(title titleLocalization: Localization.Onboarding, description descriptionLocalization: Localization.Onboarding, image imageAsset: AppConstants.Images) {
        self.title = titleLocalization.text
        self.description = descriptionLocalization.text
        self.image = imageAsset.toImage
    }
}
