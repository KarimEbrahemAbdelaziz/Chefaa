//
//  BrandItemViewModel.swift
//  Chefaa
//
//  Created by KarimEbrahem on 9/8/20.
//  Copyright © 2020 KarimEbrahem. All rights reserved.
//

import Foundation
import Domain

final class BrandItemViewModel   {
    
    let title: String
    var image: URL?
    
    init(with brand: Brand) {
        self.title = brand.title
        guard let image = brand.images.first else {
            return
        }
        
        self.image = URL(string: "https://chefaa.com/\(image)".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? "")
    }
}
