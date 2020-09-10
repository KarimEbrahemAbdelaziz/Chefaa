//
//  SliderItemViewModel.swift
//  Chefaa
//
//  Created by KarimEbrahem on 9/8/20.
//  Copyright © 2020 KarimEbrahem. All rights reserved.
//

import Foundation
import Domain

final class SliderItemViewModel   {
    
    let title: String
    let image: URL?
    
    init(with slider: SliderAdvertisement) {
        self.title = slider.title
        self.image = URL(string: "https://chefaa.com/\(slider.image)")
    }
}
