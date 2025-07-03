//
//  BaseInteractor.swift
//  iosBase
//
//  Created by Okan Orkun on 29.05.2025.
//

/// A base protocol for interactor layer abstraction.
protocol BaseInteractorProtocol: AnyObject {}

/// A base class providing shared network management for interactors.
class BaseInteractor: BaseInteractorProtocol {
    let networkManager: NetworkServiceProtocol

    init(networkManager: NetworkServiceProtocol = NetworkService.shared) {
        self.networkManager = networkManager
    }
}
