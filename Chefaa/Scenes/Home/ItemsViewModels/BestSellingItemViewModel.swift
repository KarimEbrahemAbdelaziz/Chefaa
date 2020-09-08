//
//  BestSellingItemViewModel.swift
//  Chefaa
//
//  Created by KarimEbrahem on 9/8/20.
//  Copyright © 2020 KarimEbrahem. All rights reserved.
//

import Foundation
import Domain

final class BestSellingItemViewModel   {
    
    let title: String
    let image: String
    let price: String
    
    init(with item: Item) {
        self.title = item.title
        self.price = "\(item.price)"
        guard let image = item.images.first else {
            self.image = ""
            return
        }
        
        self.image = "https://chefaa.com/\(image)"
    }
}
