//
//  NetworkProvider.swift
//  NetworkPlatform
//
//  Created by KarimEbrahem on 9/8/20.
//  Copyright © 2020 KarimEbrahem. All rights reserved.
//

import Foundation
import Domain

final class NetworkProvider {
    private let apiEndpoint: String

    public init() {
        apiEndpoint = "https://chefaa.com/api/store"
    }

    public func makeHomeNetwork() -> HomeNetwork {
        let network = Network<Home>(apiEndpoint)
        return HomeNetwork(network: network)
    }

}

