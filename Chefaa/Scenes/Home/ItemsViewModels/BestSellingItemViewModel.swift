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
    var image: URL?
    let price: String
    
    init(with item: Item) {
        self.title = item.title
        self.price = "\(item.price) EGP"
        guard let image = item.images.first else {
            return
        }
        
        self.image = URL(string: "https://chefaa.com/\(image)".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? "")
    }
}
