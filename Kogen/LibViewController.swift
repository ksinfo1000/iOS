//
//  LibViewController.swift
//  KozhenSpromozhen
//
//  Created by Kogen on 7/25/17.
//  Copyright © 2017 KozhenSpromozhen. All rights reserved.
//

import UIKit
import FacebookCore

class LibViewController: UIViewController {

//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//    }
    
    func setFBUser(){
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
        }
    }
}
