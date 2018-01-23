//
//  RequestManager.swift
//  VKDesign(11September)
//
//  Created by BLVCK on 18/01/2018.
//  Copyright © 2018 blvvvck production. All rights reserved.
//

import Foundation

class RequestManager {
    
    static let instance = RequestManager()

    var token: String = ""
    var user_id: String = ""
    
    
    func getInfo(completionBlock: @escaping (UserRegistration) -> ()) {
        
        guard let url = URL(string: "https://api.vk.com/method/account.getProfileInfo?access_token=\(token)&v=V") else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                
                print("Error: \(String(describing: error?.localizedDescription))")
                
            } else {
                
                guard let data = data else { return }

                
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch let errorMessage2 {
                    print(errorMessage2.localizedDescription)
                }
                
                do {
                    var modelDictionary = try JSONDecoder().decode([String: UserRegistration].self, from: data)
                    print("Data: \(String(describing: modelDictionary))")
                    if let model = modelDictionary["response"] {
                        completionBlock(model)
                    }

                } catch let errorMessage {
                    print(errorMessage.localizedDescription)
                }
                
                
            }
            
            
        }.resume()
        
    }
    
    func getAvatar(completionBlock: @escaping (String) -> () ) {
        guard let url = URL(string: "https://api.vk.com/method/users.get?user_ids=\(user_id)&fields=photo_100&access_token=\(token)&v=V") else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                
                print("Error: \(String(describing: error?.localizedDescription))")
                
            } else {
                
                guard let data = data else { return }
                
                
                do {
                    guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else { return }
                    guard let fixedJson = json["response"] as? [[String: Any]] else { return }
                    if let photo = fixedJson[0]["photo_100"] as? String {

                        
                        completionBlock(photo)
                    }
                    print(json)
                } catch let errorMessage2 {
                    print(errorMessage2.localizedDescription)
                }
                
                
            }
            
            
            }.resume()
        
    }
    
    func getNews(completionBlock: @escaping (NewsTest) -> ()) {
        
        guard let url = URL(string: "https://api.vk.com/method/wall.get?user_ids=\(user_id)&count=20&filter=owner&access_token=\(token)&v=5.71") else { return }
        
        
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                
                print("Error: \(String(describing: error?.localizedDescription))")
                
            } else {
                
                guard let data = data else { return }
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch let errorMessage2 {
                    print(errorMessage2.localizedDescription)
                }
    
                do {
                    var modelDictionary = try JSONDecoder().decode(NewsTest.self, from: data)
                   let response = modelDictionary.response
//                    response.items.forEach
//                        { print($0.text) }
                    print("Data: \(String(describing: modelDictionary))")
//                    if let model = modelDictionary["response"] {
//                        print(String(describing: model))
//                    }
                    completionBlock(modelDictionary)

                } catch let errorMessage {
                    print(errorMessage.localizedDescription)
                }
                
                
            }
            
            
            }.resume()
    }
    
}
