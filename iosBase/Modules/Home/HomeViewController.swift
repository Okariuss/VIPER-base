//
//  HomeViewController.swift
//  iosBase
//
//  Created by Okan Orkun on 29.05.2025.
//

import UIKit

/// View controller responsible for displaying the Home screen UI.
final class HomeViewController: BaseViewController {
    var presenter: HomePresenterProtocol!

    private lazy var label = addLabel(text: Localization.Home.home.text)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        presenter.viewDidLoad()
        setupUI()
        Task {
            await presenter.loadHomeData()
        }
    }

    /// Sets up UI elements and constraints for the Home screen.
    private func setupUI() {
        view.addSubviews(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            ),
            label.centerYAnchor.constraint(
                equalTo: view.centerYAnchor
            ),
            label.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 20
            ),
            label.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -20
            )
        ])
    }
}
