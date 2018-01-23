//
//  TestUserRegistration.swift
//  VKDesign(11September)
//
//  Created by BLVCK on 19/01/2018.
//  Copyright © 2018 blvvvck production. All rights reserved.
//

import Foundation

struct TestUserRegistration {
    
    var id: Int
    var name: String
    var surname: String
    var gender: String
    var email: String
    var phoneNumber: String
    var age: String
    var city: String
    var password: String
    
    enum CodingKeys: String, CodingKey
    {
        case name = "first_name"
        case surname = "last_name"
        case city = "home_town"
        case age = "bdate"
        //case gender = "sex"
        //        case id = "id"
        //        case phoneNumber = "phoneNumber"
        //        case password = "password"
        //        case email = "email"
    }
    
}

extension TestUserRegistration: Decodable {
    
     init(from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try container.decode(String.self, forKey: .name)
        surname = try container.decode(String.self, forKey: .surname)
        city = try  container.decode(String.self, forKey: .city)
        age = try container.decode(String.self, forKey: .age)
        
        age = ""
        id = 0
        email = ""
        phoneNumber = ""
        password = ""
        gender = ""
    }
    
}

