//
//  BaseViewController.swift
//  iosBase
//
//  Created by Okan Orkun on 29.05.2025.
//

import UIKit

/// A protocol that defines basic view behaviors such as loading indicator and alert presentation.
@MainActor
protocol BaseViewProtocol: AnyObject {
    /// Displays or hides a loading indicator overlay.
    func showLoading(_ show: Bool)
    
    /// Shows an alert with a given title and message.
    func showAlert(title: String, message: String)
}

/// A base view controller that provides common UI behaviors for loading and error handling.
@MainActor
class BaseViewController: UIViewController, BaseViewProtocol {
    
    private lazy var overlayView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        return view
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .white
        return indicator
    }()
    
    func showLoading(_ show: Bool) {
        
        if show {
            self.view.isUserInteractionEnabled = false
            
            if self.overlayView.superview == nil {
                self.view.addSubviews(self.overlayView)
                NSLayoutConstraint.activate([
                    self.overlayView.topAnchor.constraint(equalTo: self.view.topAnchor),
                    self.overlayView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
                    self.overlayView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                    self.overlayView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
                ])
            }
            
            if self.activityIndicator.superview == nil {
                self.overlayView.addSubviews(self.activityIndicator)
                NSLayoutConstraint.activate([
                    self.activityIndicator.centerXAnchor.constraint(equalTo: self.overlayView.centerXAnchor),
                    self.activityIndicator.centerYAnchor.constraint(equalTo: self.overlayView.centerYAnchor)
                ])
            }
            
            self.activityIndicator.startAnimating()
        } else {
            self.view.isUserInteractionEnabled = true
            self.activityIndicator.stopAnimating()
            self.overlayView.removeFromSuperview()
            self.activityIndicator.removeFromSuperview()
        }
        
    }
    
    func showAlert(title: String = Localization.Common.error.text, message: String) {
        
        self.showMessage(title: title, message: message)
        
    }
}
