//
//  AdvertisementsUseCase.swift
//  NetworkPlatform
//
//  Created by KarimEbrahem on 9/8/20.
//  Copyright © 2020 KarimEbrahem. All rights reserved.
//

import Foundation
import Domain
import RxSwift

final class AdvertisementsUseCase: Domain.AdvertisementsUseCase {
    private let network: HomeNetwork

    init(network: HomeNetwork) {
        self.network = network
    }
    
    func homeComponents() -> Observable<(sliders: [SliderAdvertisement], subCategories: [SubCategory], brands: [Brand], items: [Item], landingPages: [LandingPage])> {
        let homeComponents = network.fetchHome().flatMap { home -> Observable<(sliders: [SliderAdvertisement], subCategories: [SubCategory], brands: [Brand], items: [Item], landingPages: [LandingPage])> in
            
            guard let brands = home.data?.brands,
                let sliders = home.data?.slider,
                let subCategories = home.data?.subCategories,
                let items = home.data?.bestselling,
                let landingPages = home.data?.landingPages else {
                    return Observable.of((sliders: [], subCategories: [], brands: [], items: [], landingPages: []))
            }
            
            return Observable.of((sliders: sliders, subCategories: subCategories, brands: brands, items: items, landingPages: landingPages))
        }
        
        return homeComponents
    }
    
}

struct MapFromNever: Error {}
extension ObservableType where Element == Never {
    func map<T>(to: T.Type) -> Observable<T> {
        return self.flatMap { _ in
            return Observable<T>.error(MapFromNever())
        }
    }
}
