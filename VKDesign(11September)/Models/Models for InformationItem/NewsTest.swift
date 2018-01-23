//
//  NewsTest.swift
//  VKDesign(11September)
//
//  Created by BLVCK on 22/01/2018.
//  Copyright © 2018 blvvvck production. All rights reserved.
//

import Foundation

struct NewsTest: Codable {
    
    struct Response: Codable {
        struct Items: Codable {
            let id: Int
            let text: String

            struct Attachments: Codable {
                struct Photo: Codable {
                    let photo_130: String
                }
                let photo: Photo?
            }
            let attachments: [Attachments]
            
            struct Likes: Codable {
                let count: Int
            }
            let likes: Likes
            
            struct Comments: Codable {
                let count: Int
            }
            let comments: Comments
            
            struct Reposts: Codable {
                let count: Int
            }
            let reposts: Reposts
        }
        let items: [Items]
    }
        let response: Response
    }

//extension Items {
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        id = try container.decode(Int.self, forKey: .id)
//        text = try container.decode(String.self, forKey: .text)
//
//}
    
//    var items: [Items]
////
//    enum CodingKeys: String, CodingKey {
//        case items
//
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        items = try [Items(from: decoder)]
//    }
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        for item in items {
//            try container.encode(item.id, forKey: .id)
//            try container.encode(item.text, forKey: .text)
//        }
//    }
//}
//
//struct Items: Codable {
//    var id : Int
//    var text: String
//}
