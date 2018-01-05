//
//  UserModel.swift
//  RequestsSwift
//
//  Created by Ildar Zalyalov on 18.12.2017.
//  Copyright © 2017 Ildar Zalyalov. All rights reserved.
//

import Foundation

struct UserModel {
    
    var id      : Int
    var name    : String
    var userName: String
    var email   : String
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case name = "name"
        case userName = "username"
    }
}
extension UserModel: Encodable  {

    func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(userName, forKey: .userName)
    }
}

extension UserModel: Decodable {

    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        userName = try container.decode(String.self, forKey: .userName)
    
        email = "123"
    }
}


