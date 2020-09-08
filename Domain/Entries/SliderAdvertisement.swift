//
//  SliderAdvertisement.swift
//  Domain
//
//  Created by KarimEbrahem on 9/8/20.
//  Copyright © 2020 KarimEbrahem. All rights reserved.
//

import Foundation

public struct SliderAdvertisement: Codable {
    
    public let id: Int
    public let title: String
    public let image: String
    public let url: String

    public init(id: Int,
                title: String,
                image: String,
                url: String) {
        self.id = id
        self.title = title
        self.image = image
        self.url = url
    }
    
}
