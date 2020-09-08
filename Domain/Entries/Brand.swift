//
//  Brand.swift
//  Domain
//
//  Created by KarimEbrahem on 9/8/20.
//  Copyright © 2020 KarimEbrahem. All rights reserved.
//

import Foundation

public struct Brand: Codable {
    
    public let id: Int
    public let title: String
    public let titleTrans: String
    public let slug: String
    public let images: [String]

    public init(id: Int,
                title: String,
                titleTrans: String,
                slug: String,
                images: [String]) {
        self.id = id
        self.title = title
        self.titleTrans = titleTrans
        self.images = images
        self.slug = slug
    }
    
    enum CodingKeys: String, CodingKey {
        case titleTrans = "title_trans"
        
        case id
        case title
        case slug
        case images
    }
    
}
