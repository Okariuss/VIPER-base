//
//  SceneDelegate.swift
//  iosBase
//
//  Created by Okan Orkun on 28.05.2025.
//

import UIKit

@MainActor
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    /// Called when the scene is first created and ready to set up UI
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene else { return }

        let window = UIWindow(windowScene: windowScene)
        let coordinator = AppCoordinator(window: window)
        coordinator.start()

        self.window = window
        self.appCoordinator = coordinator
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called when the scene is released by the system.
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene becomes active.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene is about to become inactive.
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called when transitioning from background to foreground.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called when transitioning from foreground to background.
    }
}
