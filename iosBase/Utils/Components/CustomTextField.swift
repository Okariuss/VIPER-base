//
//  CustomTextField.swift
//  iosBase
//
//  Created by Okan Orkun on 5.06.2025.
//

import UIKit

/// Protocol to provide icon image functionality.
protocol IconProviding {
    /// The image view displaying the icon.
    var iconImageView: UIImageView { get }
    /// Sets the icon image.
    /// - Parameter image: The UIImage to set as the icon.
    func setIcon(image: UIImage?)
}

/// Protocol to provide password toggle button functionality.
protocol PasswordToggle {
    /// The button that toggles password visibility.
    var passwordToggleButton: UIButton { get }
    /// Sets up the password toggle button's action and appearance.
    func setupPasswordToggleButton()
}

/// Protocol to configure text field appearance and behavior.
protocol TextFieldConfigurable {
    /// The type of the text field (email, password, normal).
    var type: CustomTextField.TextFieldType? { get set }
    /// The placeholder text to display.
    var placeholderText: String? { get set }
    /// The color of the placeholder text.
    var placeholderColor: UIColor? { get set }
    /// Configures the text field based on its type and placeholder.
    func configureTextField()
}

/// A custom UITextField subclass with support for icons and password toggle.
final class CustomTextField: UITextField {
    /// Defines types of text fields.
    enum TextFieldType {
        case email
        case password(secure: Bool)
        case normal
    }

    /// Image view for the icon displayed on the left.
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    /// Button to toggle password visibility.
    let passwordToggleButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(AppConstants.SystemImages.showPassword.normal, for: .normal)
        button.setImage(AppConstants.SystemImages.hidePassword.normal, for: .selected)
        button.tintColor = .text
        return button
    }()

    /// Type of the text field.
    var type: TextFieldType?
    /// Placeholder text.
    var placeholderText: String?
    /// Placeholder text color.
    var placeholderColor: UIColor?

    /// Initializes a custom text field.
    /// - Parameters:
    ///   - type: The type of the text field.
    ///   - placeholderText: The placeholder text.
    ///   - placeholderColor: The placeholder text color. Defaults to `.text`.
    ///   - image: The icon image displayed on the left.
    init(type: TextFieldType, placeholderText: String, placeholderColor: UIColor = .text, image: UIImage) {
        self.type = type
        self.placeholderText = placeholderText
        self.placeholderColor = placeholderColor
        super.init(frame: .zero)
        // Set icon image and setup icon and password button.
        setIcon(image: image)
        setupIcon()
        setupPasswordToggleButton()
        addBorderWithRoundedCorners()
        configureTextField()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Adjusts text rect to account for icon and padding.
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        // Adjust text start position for icon and padding.
        return CGRect(
            x: iconImageView.frame.maxX + 10,
            y: bounds.origin.y,
            width: bounds.width - (iconImageView.frame.width + 40),
            height: bounds.height
        )
    }

    /// Adjusts editing rect to match text rect.
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }

    /// Sets up icon image view and password toggle button layout.
    private func setupIcon() {
        // Add icon and password toggle button as subviews and setup constraints.
        addSubviews(iconImageView, passwordToggleButton)

        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 20),
            iconImageView.heightAnchor.constraint(equalToConstant: 20),

            passwordToggleButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            passwordToggleButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }

    /// Adds a border with rounded corners to the text field.
    private func addBorderWithRoundedCorners() {
        layer.cornerRadius = 10
        layer.maskedCorners = [
            .layerMinXMinYCorner,
            .layerMinXMaxYCorner,
            .layerMaxXMinYCorner
        ]
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.text.cgColor
        layer.masksToBounds = true
    }
}

// MARK: - IconProviding Extension
extension CustomTextField: IconProviding {
    /// Sets the icon image with proper tinting.
    /// - Parameter image: UIImage to set as the icon.
    func setIcon(image: UIImage?) {
        iconImageView.image = image?.withTintColor(.text, renderingMode: .alwaysOriginal)
    }
}

// MARK: - PasswordToggle Extension
extension CustomTextField: PasswordToggle {
    /// Sets up the password toggle button action.
    func setupPasswordToggleButton() {
        passwordToggleButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
    }

    /// Toggles the password visibility and updates the toggle button state.
    @objc func togglePasswordVisibility() {
        // Toggle secure text entry and update button state.
        isSecureTextEntry.toggle()
        passwordToggleButton.isSelected = !isSecureTextEntry
    }
}

// MARK: - TextFieldConfigurable Extension
extension CustomTextField: TextFieldConfigurable {
    /// Configures the text field properties based on its type.
    func configureTextField() {
        guard let type = type else { return }

        switch type {
        case .email:
            keyboardType = .emailAddress
            isSecureTextEntry = false
            passwordToggleButton.isHidden = true
        case .password(let secure):
            keyboardType = .default
            isSecureTextEntry = secure
            passwordToggleButton.isHidden = false
        case .normal:
            keyboardType = .default
            isSecureTextEntry = false
            passwordToggleButton.isHidden = true
        }

        // Set the placeholder with the desired color.
        attributedPlaceholder = NSAttributedString(
            string: placeholderText ?? "",
            attributes: [NSAttributedString.Key.foregroundColor: placeholderColor ?? UIColor.systemGray3]
        )
    }
}
