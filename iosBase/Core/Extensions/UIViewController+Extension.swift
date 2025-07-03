//
//  UIViewController+Extension.swift
//  iosBase
//
//  Created by Okan Orkun on 29.05.2025.
//

import UIKit

extension UIViewController {

    // MARK: - Label

    /// Creates and returns a UILabel with optional underline, color, and font.
    /// - Parameters:
    ///   - isUnderlined: Whether the text should be underlined.
    ///   - text: The label text.
    ///   - color: The text color (default is black).
    ///   - font: The font to apply (optional).
    /// - Returns: A configured UILabel.
    func addLabel(
        isUnderlined: Bool = false,
        text: String,
        color: UIColor? = .black,
        font: UIFont? = nil
    ) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        isUnderlined ? (label.underlinedText = text) : (label.text = text)
        label.textColor = color
        label.textAlignment = .center
        label.font = font
        return label
    }

    // MARK: - ImageView

    /// Creates and returns a UIImageView with the given image.
    /// - Parameter image: The image to display.
    /// - Returns: A UIImageView with content mode set to scaleAspectFit.
    func addImageView(image: UIImage) -> UIImageView {
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }

    // MARK: - Button

    /// Creates and returns a UIButton with optional image and/or title.
    /// - Parameters:
    ///   - hasImage: Whether to show an image.
    ///   - hasTitle: Whether to show a title.
    ///   - image: The optional image.
    ///   - title: The optional title.
    ///   - tintColor: The tint color for the button and image.
    ///   - method: The selector to call when the button is tapped.
    ///   - event: The event type (default is .touchUpInside).
    /// - Returns: A configured UIButton.
    func addButton(
        hasImage: Bool = false,
        hasTitle: Bool = false,
        image: UIImage? = nil,
        title: String? = nil,
        tintColor: UIColor,
        method: Selector,
        event: UIControl.Event = .touchUpInside
    ) -> UIButton {
        let button = UIButton(type: .system)
        if let image = image, hasImage {
            let tintedImage = image.withRenderingMode(.alwaysTemplate)
            button.setImage(tintedImage, for: .normal)
        }
        if let title = title, hasTitle {
            button.setTitle(title, for: .normal)
        }
        button.tintColor = tintColor
        button.addTarget(self, action: method, for: event)
        return button
    }

    // MARK: - PageControl

    /// Creates and returns a UIPageControl with the specified properties.
    /// - Parameters:
    ///   - pages: Total number of pages.
    ///   - currentIndicatorColor: Current page indicator color.
    ///   - pageIndicatorTintColor: Default page indicator color.
    ///   - method: The selector to call when the page changes.
    /// - Returns: A configured UIPageControl.
    func addPageControl(
        pages: Int,
        currentIndicatorColor: AppColors,
        pageIndicatorTintColor: AppColors,
        method: Selector
    ) -> UIPageControl {
        let pageControl = UIPageControl(frame: .zero)
        pageControl.numberOfPages = pages
        pageControl.pageIndicatorTintColor = pageIndicatorTintColor.color
        pageControl.currentPageIndicatorTintColor = currentIndicatorColor.color
        pageControl.addTarget(self, action: method, for: .valueChanged)
        return pageControl
    }

    // MARK: - Alert

    /// Displays an alert with a title, message, and optional handler.
    /// - Parameters:
    ///   - title: The alert title.
    ///   - message: The alert message.
    ///   - handler: An optional handler to execute when the user taps OK.
    func showMessage(
        title: String,
        message: String,
        handler: ((_ action: UIAlertAction) -> Void)? = nil
    ) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(
            UIAlertAction(
                title: Localization.Common.ok.text,
                style: .default,
                handler: handler
            )
        )
        present(alert, animated: true, completion: nil)
    }
}
