//
//  AppDelegate.swift
//  PostReader
//
//  Created by Marcin Rainka @Home on 18/03/2019.
//  Copyright © 2019 Marcin Rainka. All rights reserved.
//

import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder {

    var window: UIWindow?

    private func configureWindow() {
        let window = UIWindow(frame: UIScreen.main.bounds)

        let postsView = PostsViewController()
        postsView.configure(with: .init())

        let navigation = UINavigationController(rootViewController: postsView)
        navigation.hidesBarsOnSwipe = true
        navigation.navigationBar.barStyle = .black

        window.rootViewController = navigation

        window.makeKeyAndVisible()

        self.window = window
    }
}

extension AppDelegate: UIApplicationDelegate {

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?)
            -> Bool
    {
        configureWindow()
        return true
    }
}
