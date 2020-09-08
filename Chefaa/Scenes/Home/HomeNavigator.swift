//
//  HomeNavigator.swift
//  Chefaa
//
//  Created by KarimEbrahem on 9/8/20.
//  Copyright © 2020 KarimEbrahem. All rights reserved.
//

import Foundation
import UIKit
import Domain

protocol HomeNavigator {
    func toHome()
}

class DefaultHomeNavigator: HomeNavigator {
    private let storyBoard: UIStoryboard
    private let navigationController: UINavigationController
    private let services: UseCaseProvider

    init(services: UseCaseProvider,
         navigationController: UINavigationController,
         storyBoard: UIStoryboard) {
        self.services = services
        self.navigationController = navigationController
        self.storyBoard = storyBoard
    }
    
    func toHome() {
        let viewController = storyBoard.instantiateViewController(ofType: HomeViewController.self)
        viewController.viewModel = HomeViewModel(
            useCase: services.makeAdvertisementsUseCase(),
            navigator: self
        )
        navigationController.pushViewController(viewController, animated: true)
    }

}
