//
//  IsLiked.swift
//  VKDesign(11September)
//
//  Created by BLVCK on 23/01/2018.
//  Copyright © 2018 blvvvck production. All rights reserved.
//

import Foundation

struct IsLiked: Codable {
    struct Response: Codable {
        let liked: Int
    }
    
    let response: Response
}
