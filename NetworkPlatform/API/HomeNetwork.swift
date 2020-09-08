//
//  HomeNetwork.swift
//  NetworkPlatform
//
//  Created by KarimEbrahem on 9/8/20.
//  Copyright © 2020 KarimEbrahem. All rights reserved.
//

import Foundation
import Domain
import RxSwift

public final class HomeNetwork {
    private let network: Network<Home>

    init(network: Network<Home>) {
        self.network = network
    }

    public func fetchHome() -> Observable<Home> {
        return network.getItem("home-page")
    }

}
