//
//  AdvertisementsUseCase.swift
//  Domain
//
//  Created by KarimEbrahem on 9/8/20.
//  Copyright © 2020 KarimEbrahem. All rights reserved.
//

import Foundation
import RxSwift

public typealias HomeComponentsTypeAlias = (sliders: [SliderAdvertisement], subCategories: [SubCategory], brands: [Brand], items: [Item], landingPages: [LandingPage])

public protocol AdvertisementsUseCase {
    func homeComponents() -> Observable<HomeComponentsTypeAlias>
}
