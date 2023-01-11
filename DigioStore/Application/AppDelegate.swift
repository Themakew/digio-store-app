//
//  AppDelegate.swift
//  DigioStore
//
//  Created by Ruyther Costa on 09/01/23.
//

import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Private Properties

    private(set) lazy var mainWindow = UIWindow()
    private let router = AppCoordinator().strongRouter

    // MARK: - Internal Methods

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        mainWindow.backgroundColor = .white
        router.setRoot(for: mainWindow)
        return true
    }
}
