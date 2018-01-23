//
//  LoginViewController.swift
//  VKDesign(11September)
//
//  Created by BLVCK on 30/10/2017.
//  Copyright © 2017 blvvvck production. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var authWebView: UIWebView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    let loginSegueIdentifier = "loginSeque"
    @IBOutlet weak var errorLabel: UILabel!
    let errorMessage = "Заполните все поля"
    let adminPassword = "admin"
    let adminEmail = "admin"
    var user_password = ""
    var user_email = ""
    var manager: DataManager!
    var requestManager = RequestManager.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager = DataManager()
        hideKeyboardWhenTappedAround()
        self.authWebView.delegate = self
        
        let url = URL(string: "https://oauth.vk.com/authorize?client_id=6343752&display=page&redirect_uri=https://oauth.vk.com/blank.html&scope=friends,wall&response_type=token&v=5.52")
        if let unwrappedURL = url {
            
            let request = URLRequest(url: unwrappedURL)
            let session = URLSession.shared
            
            let task = session.dataTask(with: request) { (data, response, error) in
                
                if error == nil {
                    
                    DispatchQueue.main.async {
                        
                        self.authWebView.loadRequest(request)

                    }
                    
                } else {
                    
                    print("ERROR: \(error)")
                    
                }
                
            }
            
            task.resume()
            
        }
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
        var user = [AnyHashable: Any]()
        let currentURL: String? = webView.request?.url?.absoluteString
        var textRange: NSRange? = (currentURL?.lowercased() as NSString?)?.range(of: "access_token".lowercased())
        if textRange?.location != NSNotFound {
            let data = currentURL?.components(separatedBy: CharacterSet(charactersIn: "=&"))
            user["access_token"] = data?[1]
            print(data?[1])
            user["expires_in"] = data?[3]
            user["user_id"] = data?[5]
            print(data?[5])
            requestManager.token = (data?[1])!
            requestManager.user_id = (data?[5])!
            requestManager.getInfo(completionBlock: { (userReg) in
                
                print(userReg.age)
                let ageArr: [String] = userReg.age.components(separatedBy: ".")
                print(ageArr)
                userReg.age = String(2018 - Int(ageArr[2])!)
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let navViewController = storyboard.instantiateViewController(withIdentifier: "viewControllerNav") as! UINavigationController
                
                let viewController = navViewController.topViewController as! ViewController
                viewController.userRegistration = userReg
                
                self.requestManager.getAvatar(completionBlock: { (url) in
                    viewController.photoUrl = url
                })
                self.present(navViewController, animated: true, completion: nil)
            })
        }
    }

    @IBAction func loginButtonPressed(_ sender: Any) {
        
        if let password = passwordTextField.text {
            user_password = password
        }
        
        if let email = emailTextField.text {
            user_email = email
        }
        
        if (passwordTextField.text == adminPassword && emailTextField.text == adminEmail) {
            performSegue(withIdentifier: loginSegueIdentifier, sender: nil)
        } else if (passwordTextField.text == "" && emailTextField.text == "") {
            errorLabel.text = errorMessage
        } else if UserRepository.sharedInstance.check(with: user_email, and: user_password) {
            //DataManager.currentUser = UserRepository.sharedInstance.identifyCurrentUser(with: user_email)
            performSegue(withIdentifier: loginSegueIdentifier, sender: nil)
        }
        else {
            errorLabel.text = errorMessage
        }
    }
}
