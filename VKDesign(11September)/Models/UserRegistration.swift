//
//  UserRegistration.swift
//  VKDesign(11September)
//
//  Created by BLVCK on 30/10/2017.
//  Copyright © 2017 blvvvck production. All rights reserved.
//

import UIKit

class UserRegistration: NSObject, Decodable {

    var id: Int
    var name: String
    var surname: String
    var gender: String
    var email: String
    var phoneNumber: String
    var age: String
    var city: String
    var password: String
    
    init(name: String, surname: String, gender: String, email: String, phoneNumber: String, age: String, city: String, password: String) {
        self.id = 0
        self.name = name
        self.surname = surname
        self.gender = gender
        self.email = email
        self.phoneNumber = phoneNumber
        self.age = age
        self.city = city
        self.password = password
    }
    
    init(id: Int, name: String, surname: String, gender: String, email: String, phoneNumber: String, age: String, city: String, password: String) {
        self.id = id
        self.name = name
        self.surname = surname
        self.gender = gender
        self.email = email
        self.phoneNumber = phoneNumber
        self.age = age
        self.city = city
        self.password = password
    }
//    
//    func encode(with aCoder: NSCoder) {
//        
//    }
    
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
    
    required init(from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try container.decode(String.self, forKey: .name)
        surname = try container.decode(String.self, forKey: .surname)
        city = try  container.decode(String.self, forKey: .city)
        age = try container.decode(String.self, forKey: .age)
        
    
        id = 0
        email = ""
        phoneNumber = ""
        password = ""
        gender = ""
    }
}

