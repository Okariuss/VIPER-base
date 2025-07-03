//
//  CustomButton.swift
//  iosBase
//
//  Created by Okan Orkun on 29.05.2025.
//

import UIKit

/// Protocol that provides gradient layer setup and layout functionality.
protocol GradientProviding {
    /// The gradient layer applied to the view.
    var gradientLayer: CAGradientLayer? { get }
    
    /// Sets up the gradient layer with the given colors.
    /// - Parameter colors: An array of UIColor for the gradient.
    func setupGradient(colors: [UIColor])
    
    /// Updates the gradient layer's frame and re-inserts it into the layer hierarchy.
    func layoutGradient()
}

/// Protocol that provides title management for UI controls.
protocol TitleProviding {
    /// The current title value for the control.
    var titleValue: String? { get }
    
    /// Sets the title for a specified control state.
    /// - Parameters:
    ///   - title: The title string to set.
    ///   - state: The UIControl.State for which to set the title.
    func setTitleValue(_ title: String?, for state: UIControl.State)
}

/// A custom UIButton subclass that supports gradient backgrounds and title management.
final class CustomButton: UIButton {
    
    /// The gradient layer used as the button's background.
    var gradientLayer: CAGradientLayer?
    
    /// The current title text of the button.
    var titleValue: String?
    
    /// Initializes a CustomButton with gradient colors and an optional title.
    /// - Parameters:
    ///   - gradientColors: An array of UIColor values for the gradient background.
    ///   - title: The optional title text for the button.
    init(gradientColors: [UIColor], title: String?) {
        self.titleValue = title
        super.init(frame: .zero)
        
        setTitleColor(.white, for: .normal)
        titleLabel?.font = Theme.defaultTheme().themeFont.bodyFont
        
        setupGradient(colors: gradientColors)
        setTitleValue(title, for: .normal)
    }
    
    /// Required initializer. Not implemented.
    /// - Parameter coder: NSCoder instance.
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Lays out subviews and updates the gradient layer frame to match bounds.
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer?.frame = bounds
    }
}

// MARK: - GradientProviding
extension CustomButton: GradientProviding {
    
    /// Configures the gradient layer with specified colors and adds it as a sublayer.
    /// - Parameter colors: Array of UIColor to create the gradient.
    func setupGradient(colors: [UIColor]) {
        gradientLayer = CAGradientLayer()
        gradientLayer?.frame = bounds
        gradientLayer?.colors = colors.map { $0.cgColor }
        gradientLayer?.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer?.endPoint = CGPoint(x: 1, y: 1)
        
        if let gradientLayer = gradientLayer {
            layer.insertSublayer(gradientLayer, at: 0)
        }
    }
    
    /// Updates the gradient layer's frame and re-inserts it to ensure proper rendering.
    func layoutGradient() {
        gradientLayer?.frame = bounds
        if let gradientLayer = gradientLayer {
            layer.insertSublayer(gradientLayer, at: 0)
        }
    }
}

// MARK: - TitleProviding
extension CustomButton: TitleProviding {
    
    /// Sets the title for the button and updates the internal title value.
    /// - Parameters:
    ///   - title: The new title string.
    ///   - state: The UIControl.State for which the title should be set.
    func setTitleValue(_ title: String?, for state: UIControl.State) {
        titleValue = title
        setTitle(title, for: state)
    }
}
