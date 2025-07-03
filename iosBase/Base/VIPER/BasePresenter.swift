//
//  BasePresenter.swift
//  iosBase
//
//  Created by Okan Orkun on 29.05.2025.
//

/// A protocol defining base presenter lifecycle behavior.
@MainActor
protocol BasePresenterProtocol: AnyObject {
    /// Called when the view has finished loading.
    func viewDidLoad()
}

/// Base implementation of presenter layer.
@MainActor
class BasePresenter: BasePresenterProtocol {
    func viewDidLoad() {
        Logger.log("BasePresenter viewDidLoad")
    }
}
