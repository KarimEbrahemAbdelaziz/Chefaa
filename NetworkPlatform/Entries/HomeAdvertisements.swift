//
//  HomeAdvertisements.swift
//  NetworkPlatform
//
//  Created by KarimEbrahem on 9/8/20.
//  Copyright © 2020 KarimEbrahem. All rights reserved.
//

import Foundation
import Domain

final public class Home: Codable {
    public var data: HomeAdvertisements?
    public var code: Int?
}

final public class HomeAdvertisements: Codable {
    public var slider: [Domain.SliderAdvertisement]?
    public var subCategories: [Domain.SubCategory]?
    public var brands: [Domain.Brand]?
    public var bestselling: [Domain.Item]?
    public var landingPages: [Domain.LandingPage]?
    public var landing_page_title: String?
}
