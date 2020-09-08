//
//  UseCaseProvider.swift
//  NetworkPlatform
//
//  Created by KarimEbrahem on 9/8/20.
//  Copyright © 2020 KarimEbrahem. All rights reserved.
//

import Foundation
import Domain

public final class UseCaseProvider: Domain.UseCaseProvider {
    
    private let networkProvider: NetworkProvider

    public init() {
        networkProvider = NetworkProvider()
    }
    
    public func makeAdvertisementsUseCase() -> Domain.AdvertisementsUseCase {
        return AdvertisementsUseCase(network: networkProvider.makeHomeNetwork())
    }

}
