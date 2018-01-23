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
    var version: String = "5.71"
    var type: String = "post"
    
    func getInfo(completionBlock: @escaping (UserRegistration) -> ()) {
        
        guard let url = URL(string: "https://api.vk.com/method/account.getProfileInfo?access_token=\(token)&v=\(version)") else { return }
        
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
        guard let url = URL(string: "https://api.vk.com/method/users.get?user_ids=\(user_id)&fields=photo_100&access_token=\(token)&v=\(version)") else { return }
        
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
        
        guard let url = URL(string: "https://api.vk.com/method/wall.get?user_ids=\(user_id)&count=20&filter=owner&access_token=\(token)&v=\(version)") else { return }

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
                    completionBlock(modelDictionary)
                } catch let errorMessage {
                    print(errorMessage.localizedDescription)
                }
            }
      
            }.resume()
    }
    
    func postNews(with text: String, completionBlock: @escaping (Bool) -> ()) {
        
        guard let url = URL(string: "https://api.vk.com/method/wall.post?user_ids=\(user_id)&message=\(text)&access_token=\(token)&v=\(version)") else { return }
        let parametrs = [""]
    
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-type")
        
        guard let httBody = try? JSONSerialization.data(withJSONObject: parametrs, options: []) else { return }
        request.httpBody = httBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                
                print("Error: \(String(describing: error?.localizedDescription))")
                
            } else {
                completionBlock(true)
            }
        }.resume()
    }
    
    func likePost(with id: Int) {
        guard let url = URL(string: "https://api.vk.com/method/likes.add?type=\(type)&owner_id=\(user_id)&item_id=\(id)&access_token=\(token)&v=\(version)") else { return }
        let parametrs = [""]
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-type")
        
        guard let httBody = try? JSONSerialization.data(withJSONObject: parametrs, options: []) else { return }
        request.httpBody = httBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
           
            if let response = response{
                print(response)
            }
            
            guard let data = data else { return }
            
            do {
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func isLiked(with id: Int, completionBlock: @escaping (Int) -> ()) {
        guard let url = URL(string: "https://api.vk.com/method/likes.isLiked?user_id=\(user_id)&type=\(type)&owner_id=\(user_id)&item_id=\(id)&access_token=\(token)&v=\(version)") else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                
                print("Error: \(String(describing: error?.localizedDescription))")
                
            } else {
                
                    guard let data = data else { return }
                
                    do {
                        var isLikedModel = try JSONDecoder().decode(IsLiked.self, from: data)
                        completionBlock(isLikedModel.response.liked)
                        
                    } catch let errorMessage {
                        print(errorMessage.localizedDescription)
                    }
                }
            }.resume()
    }
    
    func unLikePost(with id: Int) {
        guard let url = URL(string: "https://api.vk.com/method/likes.delete?type=\(type)&owner_id=\(user_id)&item_id=\(id)&access_token=\(token)&v=\(version)") else { return }
        let parametrs = [""]
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-type")
        
        guard let httBody = try? JSONSerialization.data(withJSONObject: parametrs, options: []) else { return }
        request.httpBody = httBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response{
                print(response)
            }
            
            guard let data = data else { return }
            
            do {
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
