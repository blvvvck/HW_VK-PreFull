//
//  RSSFeed.swift
//  VKDesign(11September)
//
//  Created by BLVCK on 22/01/2018.
//  Copyright © 2018 blvvvck production. All rights reserved.
//

import Foundation

struct RSSFeed: Codable {
    struct Feed: Codable {
        struct Podcast: Codable {
            let name: String
            let artistName: String
            let url: URL
            let releaseDate: Date
        }
        
        let podcasts: [Podcast]
        
        private enum CodingKeys: String, CodingKey {
            case podcasts = "results"
        }
    }
    
    let feed: Feed
}

typealias Feed = RSSFeed.Feed
typealias Podcast = Feed.Podcast
