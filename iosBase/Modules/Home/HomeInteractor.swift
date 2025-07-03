//
//  HomeInteractor.swift
//  iosBase
//
//  Created by Okan Orkun on 29.05.2025.
//

import Foundation

/// Protocol defining the responsibilities for the home screen interactor.
protocol HomeInteractorProtocol: BaseInteractorProtocol {
    /// Fetches data required for displaying on the home screen.
    func fetchHomeData() async throws
}

/// Interactor responsible for fetching and managing data on the home screen.
final class HomeInteractor: BaseInteractor, HomeInteractorProtocol {
    /// Simulates data fetching for the home screen.
    func fetchHomeData() async throws {
        Logger.log("Fetched home data")
    }
}
