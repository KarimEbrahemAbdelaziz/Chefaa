//
//  LandingPage.swift
//  Domain
//
//  Created by KarimEbrahem on 9/8/20.
//  Copyright © 2020 KarimEbrahem. All rights reserved.
//

import Foundation

public struct LandingPage: Codable {
    
    public let id: Int
    public let name: String
    public let description: String
    public let image: String

    public init(id: Int,
                name: String,
                description: String,
                image: String) {
        self.id = id
        self.name = name
        self.description = description
        self.image = image
    }
    
}
