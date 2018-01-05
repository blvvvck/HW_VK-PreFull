//
//  ViewController.swift
//  RequestsSwift
//
//  Created by Ildar Zalyalov on 18.12.2017.
//  Copyright © 2017 Ildar Zalyalov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        obtainUser()
    }

    func obtainUser() {
        
        guard let url = URL(string: "http://jsonplaceholder.typicode.com/users/1") else { return }
        
            var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 10)
        
            urlRequest.httpMethod = "GET"
        
            let session = URLSession.shared
        
            let task = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
                
                if error != nil {
                    
                    print("Error: \(String(describing: error?.localizedDescription))")
                }
                else {
                    
                    guard let data = data else { return }
                    
                    if let model = try? JSONDecoder().decode(UserModel.self, from: data) {
                        print("Data: \(String(describing: model))")
                    }
                }
            })
            
            task.resume()
    }

}

