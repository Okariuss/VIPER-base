//
//  OnboardingViewController.swift
//  iosBase
//
//  Created by Okan Orkun on 29.05.2025.
//

import UIKit

/// Protocol defining the interface for updating onboarding view pages.
protocol OnboardingViewProtocol: AnyObject {
    /// Updates the UI for the onboarding page.
    /// - Parameters:
    ///   - index: Current page index.
    ///   - entity: OnboardingEntity containing page content.
    ///   - isFirstPage: Indicates if current page is the first page.
    ///   - isLastPage: Indicates if current page is the last page.
    func updatePage(index: Int, entity: OnboardingEntity, isFirstPage: Bool, isLastPage: Bool)
}

/// View controller responsible for displaying onboarding screens.
final class OnboardingViewController: BaseViewController {
    var presenter: OnboardingPresenterProtocol!
    
    /// Image view displaying the onboarding image.
    private lazy var imageView = addImageView(image: .imgOnboard1)
    
    /// Label displaying the onboarding page title.
    private lazy var titleLabel = addLabel(
        text: Localization.Onboarding.welcomeTitle.text,
        font: Theme.defaultTheme().themeFont.largeTitleFont
    )
    
    /// Label displaying the onboarding page description.
    private lazy var descriptionLabel = addLabel(
        text: Localization.Onboarding.welcomeDescription.text,
        font: Theme.defaultTheme().themeFont.bodyFont
    )
    
    /// Page control to indicate and navigate between pages.
    private lazy var pageControl = addPageControl(
        pages: 3,
        currentIndicatorColor: .primary,
        pageIndicatorTintColor: .secondary,
        method: #selector(pageControlValueChanged)
    )
    
    /// Back button to navigate to the previous onboarding page.
    private lazy var backButton = addButton(
        hasImage: true,
        image: AppConstants.SystemImages.back.normal,
        tintColor: .black,
        method: #selector(didTapBackBtn)
    )
    
    /// Next button to navigate to the next onboarding page.
    private lazy var nextBtn = addButton(
        hasImage: true,
        image: AppConstants.SystemImages.next.normal,
        tintColor: .black,
        method: #selector(didTapNextBtn)
    )
    
    /// Skip button to skip the onboarding process.
    private lazy var skipBtn = addButton(
        hasTitle: true,
        title: Localization.Onboarding.skip.text,
        tintColor: .black,
        method: #selector(didTapSkipBtn)
    )
    
    // MARK: - Lifecycle
    
    /// Called after the controller's view is loaded into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        presenter.viewDidLoad()
        setupUI()
    }
    
    /// Called before the view is added to the window.
    /// - Parameter animated: If true, the appearance is being animated.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    /// Called before the view is removed from the window.
    /// - Parameter animated: If true, the disappearance is being animated.
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    // MARK: - UI Setup
    
    /// Adds subviews and sets up layout constraints.
    private func setupUI() {
        view.addSubviews(
            imageView,
            titleLabel,
            descriptionLabel,
            pageControl,
            backButton,
            nextBtn,
            skipBtn
        )
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: AppConstants.Spacing.large.rawValue
            ),
            imageView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: AppConstants.Spacing.small.rawValue
            ),
            imageView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -AppConstants.Spacing.small.rawValue
            ),
            imageView.heightAnchor.constraint(
                equalToConstant: .deviceHeight / 3
            ),
            
            titleLabel.topAnchor.constraint(
                equalTo: imageView.bottomAnchor,
                constant: AppConstants.Spacing.extraLarge.rawValue
            ),
            titleLabel.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            ),
            
            descriptionLabel.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: AppConstants.Spacing.small.rawValue
            ),
            descriptionLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: AppConstants.Spacing.medium.rawValue
            ),
            descriptionLabel.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -AppConstants.Spacing.medium.rawValue
            ),
            descriptionLabel.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            ),
            
            backButton.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: AppConstants.Spacing.medium.rawValue
            ),
            backButton.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -AppConstants.Spacing.medium.rawValue
            ),
            
            pageControl.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            ),
            pageControl.bottomAnchor.constraint(
                equalTo: backButton.bottomAnchor
            ),
            
            nextBtn.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -AppConstants.Spacing.medium.rawValue
            ),
            nextBtn.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -AppConstants.Spacing.medium.rawValue
            ),
            
            skipBtn.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),
            skipBtn.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -AppConstants.Spacing.small.rawValue
            )
        ])
    }
    
    // MARK: - Actions
    
    /// Called when the page control value changes.
    /// - Parameter sender: The UIPageControl instance.
    @objc private func pageControlValueChanged(_ sender: UIPageControl) {
        presenter.didSelectPage(at: sender.currentPage)
    }
    
    /// Called when the back button is tapped.
    @objc private func didTapBackBtn() {
        presenter.didTapBack()
    }
    
    /// Called when the next button is tapped.
    @objc private func didTapNextBtn() {
        presenter.didTapNext()
    }
    
    /// Called when the skip button is tapped.
    @objc private func didTapSkipBtn() {
        presenter.didTapSkip()
    }
}

extension OnboardingViewController: OnboardingViewProtocol {
    /// Updates the onboarding view with the provided page data.
    /// - Parameters:
    ///   - index: Current page index.
    ///   - entity: OnboardingEntity containing the page content.
    ///   - isFirstPage: Flag indicating if it's the first page.
    ///   - isLastPage: Flag indicating if it's the last page.
    @MainActor
    func updatePage(index: Int, entity: OnboardingEntity, isFirstPage: Bool, isLastPage: Bool) {
        titleLabel.text = entity.title
        descriptionLabel.text = entity.description
        imageView.image = entity.image
        pageControl.currentPage = index
        backButton.isHidden = isFirstPage
        nextBtn.isHidden = isLastPage
    }
}
