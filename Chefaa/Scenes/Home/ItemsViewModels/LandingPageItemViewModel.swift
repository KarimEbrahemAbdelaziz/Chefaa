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
    let image: String
    
    init(with landingPage: LandingPage) {
        self.title = landingPage.name
        self.image = landingPage.image
    }
}
