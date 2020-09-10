//
//  LandingPageItemViewModel.swift
//  Chefaa
//
//  Created by KarimEbrahem on 9/8/20.
//  Copyright © 2020 KarimEbrahem. All rights reserved.
//

import Foundation
import Domain

final class LandingPageItemViewModel   {
    
    let title: String
    let image: URL?
    
    init(with landingPage: LandingPage) {
        self.title = landingPage.name
        self.image = URL(string: "https://chefaa.com/\(landingPage.image)")
    }
}
