//
//  Item.swift
//  Domain
//
//  Created by KarimEbrahem on 9/8/20.
//  Copyright © 2020 KarimEbrahem. All rights reserved.
//

import Foundation

public struct Item: Codable {
    
    public let id: Int
    public let title: String
    public let images: [String]
    public let price: Double

    public init(id: Int,
                title: String,
                price: Double,
                images: [String]) {
        self.id = id
        self.title = title
        self.images = images
        self.price = price
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case images
        case price
    }
    
}
