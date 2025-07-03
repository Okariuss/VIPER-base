//
//  HomePresenter.swift
//  iosBase
//
//  Created by Okan Orkun on 29.05.2025.
//

import Foundation

@MainActor
protocol HomePresenterProtocol: BasePresenterProtocol {
    /// Loads home data to be displayed on the screen.
    func loadHomeData() async
}

/// Presenter responsible for handling logic and interactions on the Home screen.
@MainActor
final class HomePresenter: BasePresenter {
    private weak var view: HomeViewController?
    private let interactor: HomeInteractorProtocol
    private let router: HomeRouterProtocol

    /// Initializes the HomePresenter with required dependencies.
    /// - Parameters:
    ///   - view: The view controller displaying the Home screen.
    ///   - interactor: The interactor responsible for data fetching.
    ///   - router: The router handling navigation.
    init(view: HomeViewController, interactor: HomeInteractorProtocol, router: HomeRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }

    override func viewDidLoad() {
        Logger.log("Home screen loaded")
    }
}

extension HomePresenter: HomePresenterProtocol {
    /// Loads home data asynchronously and updates the view accordingly.
    ///
    /// This method shows a loading indicator, fetches home data using the interactor,
    /// and handles errors by displaying an alert. It ensures UI updates are performed
    /// on the main actor, following Swift concurrency best practices.
    func loadHomeData() async {
        view?.showLoading(true)
        defer { view?.showLoading(false) }
        do {
            try await interactor.fetchHomeData()
        } catch {
            Logger.log("Home data load failed: \(error.localizedDescription)")
            view?.showAlert(message: error.localizedDescription)
        }
    }
}
