//
//  SubCategoryItemViewModel.swift
//  Chefaa
//
//  Created by KarimEbrahem on 9/8/20.
//  Copyright © 2020 KarimEbrahem. All rights reserved.
//

import Foundation
import Domain

final class SubCategoryItemViewModel   {
    
    let title: String
    let image: String
    
    init(with subCategory: SubCategory) {
        self.title = subCategory.title
        self.image = "https://chefaa.com/\(subCategory.image)"
    }
}
