//
//  OnboardingInteractor.swift
//  iosBase
//
//  Created by Okan Orkun on 29.05.2025.
//

/// Protocol defining the responsibilities for onboarding data management.
protocol OnboardingInteractorProtocol: BaseInteractorProtocol {
    /// Returns an array of onboarding pages to be displayed.
    func fetchOnboardingPages() -> [OnboardingEntity]
    
    /// Marks the onboarding process as completed.
    func onboardCompleted() async
}

/// Interactor responsible for providing onboarding data and managing onboarding completion state.
final class OnboardingInteractor: BaseInteractor, OnboardingInteractorProtocol {
    
    private let sessionManager: SessionManagerProtocol
    
    init(sessionManager: SessionManagerProtocol) {
        self.sessionManager = sessionManager
    }
    
    /// Returns an array of onboarding pages with titles, descriptions, and images.
    func fetchOnboardingPages() -> [OnboardingEntity] {
        return [
            .init(
                title: .welcomeTitle,
                description: .welcomeDescription,
                image: .onboard1
            ),
            .init(
                title: .featuresTitle,
                description: .featuresDescription1,
                image: .onboard1
            ),
            .init(
                title: .readyTitle,
                description: .readyDescription,
                image: .onboard1
            )
        ]
    }
    
    /// Marks onboarding as completed.
    func onboardCompleted() async {
        sessionManager.markOnboardingAsSeen()
    }
}
