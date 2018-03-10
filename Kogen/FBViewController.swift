//
//  FBViewController.swift
//  KozhenSpromozhen
//
//  Created by Kogen on 6/11/17.
//  Copyright © 2017 KozhenSpromozhen. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore

class FBViewController: UIViewController, LoginButtonDelegate {

    @IBOutlet weak var uiStackView: UIStackView!
    @IBOutlet weak var btnAction: UIButton!
    @IBOutlet weak var lbShow: UILabel!
    
    
    @IBOutlet weak var contestBtn: UIButton!
    @IBAction func contestActionBtn(_ sender: Any) {
        if self.nominationId.characters.count > 0 {
            let viewController = ExpandingViewController()
            viewController.viewWillAppear(false)
            self.dismiss(animated: true, completion: nil)
        }
    }

    var nominationId = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if nominationId.characters.count == 0 {
            contestBtn.isHidden = true
        }

        let loginButton = LoginButton(readPermissions: [ .publicProfile, .email, .userFriends ])
        loginButton.center = view.center
        loginButton.delegate = self
        uiStackView.insertArrangedSubview(loginButton, at: 0)
        
        if AccessToken.current != nil {
            
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name,last_name, picture.type(large),email,updated_time"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    
                    if let userDict = result as? NSDictionary {
                        
                        let first_Name = userDict["first_name"] as! String
                        let last_Name = userDict["last_name"] as! String
                        let id = userDict["id"] as! String
                        let email = userDict["email"] as! String
    
                        let defaults = UserDefaults.standard
                        defaults.set(id, forKey:        "fb_user_id")
                        defaults.set(email, forKey:     "fb_email")
                        defaults.set(first_Name, forKey:"fb_first_name")
                        defaults.set(last_Name, forKey: "fb_last_name")

                        self.lbShow.text = "Привет " + first_Name + " " + last_Name
                        self.show(active : true,name:first_Name)
                    }
                }
            })
        }
        else{
            
            let defaults = UserDefaults.standard
            defaults.set(nil, forKey: "fb_user_id")
            defaults.set(nil, forKey:     "fb_email")
            defaults.set(nil, forKey:"fb_first_name")
            defaults.set(nil, forKey: "fb_last_name")
            
            self.show(active : false,name :"Вход в Facebook")
        }
        
        // Do any additional setup after loading the view.
    }

    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        
        switch result {
        case .failed(let error):
            print(error)
        case .cancelled:
            print("Пользователь аннулировал вход.")
        case .success(let grantedPermissions, let declinedPermissions, let accessToken):
            //print("Logged in!")
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name,last_name, picture.type(large),email,updated_time"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    
                    if let userDict = result as? NSDictionary {
                        let first_Name = userDict["first_name"] as! String
                        let last_Name = userDict["last_name"] as! String
                        let id = userDict["id"] as! String
                        let email = userDict["email"] as! String
                        
                        let defaults = UserDefaults.standard
                        defaults.set(id, forKey:        "fb_user_id")
                        defaults.set(email, forKey:     "fb_email")
                        defaults.set(first_Name, forKey:"fb_first_name")
                        defaults.set(last_Name, forKey: "fb_last_name")
                        
                        self.lbShow.text = "Привет " + first_Name
                        self.show(active : true,name:first_Name)
                    }
                }
            })
        }

    }
    
    func loginButtonDidLogOut(_ loginButton: LoginButton) {

        let defaults = UserDefaults.standard
        defaults.set(nil, forKey: "fb_user_id")
        defaults.set(nil, forKey:     "fb_email")
        defaults.set(nil, forKey:"fb_first_name")
        defaults.set(nil, forKey: "fb_last_name")
        
        show(active : false, name : "Вход в Facebook")
    }
    
    @IBAction func btnAction(_ sender: UIButton) {
        let loginManager = LoginManager()
        if AccessToken.current == nil {
            
            loginManager.logIn([ .publicProfile,.email,.userFriends ], viewController: self) { loginResult in
                switch loginResult {
                case .failed(let error):
                    print(error)
                case .cancelled:
                    print("Пользователь аннулировал вход.")
                case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                    print("Logged in!")
                    
                    FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name,last_name, picture.type(large),email,updated_time"]).start(completionHandler: { (connection, result, error) -> Void in
                        if (error == nil){
                            
                            if let userDict = result as? NSDictionary {
                                
                                let first_Name = userDict["first_name"] as! String
                                let last_Name = userDict["last_name"] as! String
                                let id = userDict["id"] as! String
                                let email = userDict["email"] as! String
                                

                                let defaults = UserDefaults.standard
                                defaults.set(id, forKey:        "fb_user_id")
                                defaults.set(email, forKey:     "fb_email")
                                defaults.set(first_Name, forKey:"fb_first_name")
                                defaults.set(last_Name, forKey: "fb_last_name")
                                
                                self.lbShow.text = "Привет " + first_Name
                                self.show(active : true,name:first_Name)
                                
                            }
                        }
                    })
                }
            }
        }else{
            loginManager.logOut()
            show(active : false,name:"Вход в Facebook")
        }
    }
    
    func show(active : Bool, name : String){
        
        if active{
            self.btnAction.setTitle("Выход", for: .normal)
            self.lbShow.text = "Привет " + name
        }
        else{
            self.btnAction.setTitle("", for: .normal)
            //self.btnAction.setTitle("Пользовательский вход", for: .normal)
            self.lbShow.text = name
        }
        
    }
    
}
