//
//  OnboardingPresenter.swift
//  iosBase
//
//  Created by Okan Orkun on 29.05.2025.
//

import Foundation

@MainActor
protocol OnboardingPresenterProtocol: BasePresenterProtocol {
    /// Called when a page is selected.
    /// - Parameter index: The index of the selected page.
    func didSelectPage(at index: Int)
    
    /// Called when the back button is tapped.
    func didTapBack()
    
    /// Called when the next button is tapped.
    func didTapNext()
    
    /// Called when the skip button is tapped.
    func didTapSkip()
}

/// Presenter responsible for handling the onboarding screen logic and user interactions.
@MainActor
final class OnboardingPresenter: BasePresenter {
    private weak var view: OnboardingViewController?
    private let interactor: OnboardingInteractorProtocol
    private let router: OnboardingRouterProtocol
    
    private var pages: [OnboardingEntity]
    private var currentIndex: Int = 0

    /// Initializes the presenter with dependencies.
    /// - Parameters:
    ///   - view: The onboarding view controller.
    ///   - interactor: The onboarding interactor.
    ///   - router: The onboarding router.
    init(
        view: OnboardingViewController,
        interactor: OnboardingInteractorProtocol,
        router: OnboardingRouterProtocol
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.pages = interactor.fetchOnboardingPages()
    }

    override func viewDidLoad() {
        Logger.log("Onboarding screen loaded")
        view?.updatePage(
            index: currentIndex,
            entity: pages[currentIndex],
            isFirstPage: isFirstPage,
            isLastPage: isLastPage
        )
    }
    
    // MARK: - Private Properties
    
    private var isLastPage: Bool {
        currentIndex == pages.count - 1
    }
    
    private var isFirstPage: Bool {
        currentIndex == 0
    }
    
    // MARK: - Private Methods
    
    private func completeOnboarding() async {
        await interactor.onboardCompleted()
        await router.navigate(to: .login)
    }
}

extension OnboardingPresenter: OnboardingPresenterProtocol {
    func didSelectPage(at index: Int) {
        guard index >= 0, index < pages.count else { return }
        currentIndex = index
        view?.updatePage(
            index: currentIndex,
            entity: pages[currentIndex],
            isFirstPage: isFirstPage,
            isLastPage: isLastPage
        )
    }

    func didTapBack() {
        guard currentIndex > 0 else { return }
        currentIndex -= 1
        view?.updatePage(
            index: currentIndex,
            entity: pages[currentIndex],
            isFirstPage: isFirstPage,
            isLastPage: isLastPage
        )
    }
    
    func didTapNext() {
        guard !isLastPage else {
            Task { await completeOnboarding() }
                    return
        }
        
        currentIndex += 1
        view?.updatePage(
            index: currentIndex,
            entity: pages[currentIndex],
            isFirstPage: isFirstPage,
            isLastPage: isLastPage
        )
        
    }
    
    func didTapSkip() {
        Task {
            await completeOnboarding()
        }
    }
}
