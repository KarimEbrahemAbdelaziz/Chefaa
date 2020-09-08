//
//  Application.swift
//  Chefaa
//
//  Created by KarimEbrahem on 9/8/20.
//  Copyright © 2020 KarimEbrahem. All rights reserved.
//

import Foundation
import UIKit
import Domain
import NetworkPlatform

final class Application {
    static let shared = Application()

    private let networkUseCaseProvider: Domain.UseCaseProvider

    private init() {
        self.networkUseCaseProvider = NetworkPlatform.UseCaseProvider()
    }

    func configureMainInterface(in window: UIWindow) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let navigationController = UINavigationController()
        navigationController.setNavigationBarHidden(true, animated: false)
        navigationController.tabBarItem = UITabBarItem(title: "Home",
                image: UIImage(named: "home"),
                selectedImage: nil)
        let networkNavigator = DefaultHomeNavigator(
            services: networkUseCaseProvider,
            navigationController: navigationController,
            storyBoard: storyboard
        )

        let tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = UIColor(red: 0.00, green: 0.80, blue: 0.49, alpha: 1.00)
        tabBarController.viewControllers = [
                navigationController
        ]
        window.rootViewController = tabBarController

        networkNavigator.toHome()
    }
}
