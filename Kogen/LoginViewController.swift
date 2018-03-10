//
//  LoginViewController.swift
//  Kogen
//
//  Created by Kogen on 8/16/16.
//  Copyright © 2016 Kogen. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {

    @IBOutlet weak var main: UITabBarItem!
    
    
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    @IBOutlet weak var mess: UILabel!
    
    var baseURL = "http://ksinfo1000.com/backend.php/connect/signin"
    var email_address = ""
    var password = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        assignbackground()
        
        UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
        
        //self.performSegueWithIdentifier("loginUser", sender: self)
        // Do any additional setup after loading the view, typically from a nib.
    }
    func assignbackground(){
        let background = UIImage(named: "luxfon.com_1")
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIViewContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubview(toBack: imageView)
    }

    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    override var preferredInterfaceOrientationForPresentation : UIInterfaceOrientation {
        return UIInterfaceOrientation.portrait
    }
    
    @IBAction func back1(_ sender: AnyObject) {
        
                  //  self.dismissViewControllerAnimated(true, completion:nil);
        
        DispatchQueue.main.async(execute: {
                        //self.dismissViewControllerAnimated(true, completion:nil);
            //self.performSegueWithIdentifier("loginUser", sender: self)
        })
        
        
    }
    /*
    @IBAction func back(sender: AnyObject) {
        let delay = 4.5 * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        
        dispatch_after(time, dispatch_get_main_queue()) {
            self.performSegueWithIdentifier("backUser", sender: self)
        }
        
    }
 */
    
    @IBAction func loginButtonTapped(_ sender: AnyObject) {
        
        var userEmail = "";
        if let userEmailF = userEmailTextField.text {
            userEmail = userEmailF
        }
        
        var userPassword = "";
        if let userPasswordF = userPasswordTextField.text {
            userPassword = userPasswordF
        }
        
        
        email_address = String(userEmail);
        password = String(userPassword);
        
        let baseURLw = baseURL + "?email_address=\(self.email_address)&password=\(self.password)"
        
        
        let url = URL(string: baseURLw)
        
        var myStatus = ""
        var myMessage = ""
        var first_name = ""
        var last_name = ""
        
        Alamofire.request(url!).responseJSON { response in
            if let value = response.result.value as? [String: AnyObject] {
                if let signin = value["signin"] as? [String: AnyObject]
                {
                    if (signin["status"] != nil)
                    {
                        myStatus = signin["status"] as! String
                    }
                    if (signin["message"] != nil)
                    {
                        myMessage = signin["message"] as! String
                    }
                    
                    if (myStatus == "Success")
                    {
                        if (signin["first_name"] != nil)
                        {
                            first_name = signin["first_name"] as! String
                        }
                        if (signin["last_name"] != nil)
                        {
                            last_name = signin["last_name"] as! String
                        }
                        
                        let defaults = UserDefaults.standard

                        defaults.set(true,forKey:"isUserLoggedIn");
                        defaults.set(first_name, forKey: "userFirstName")
                        defaults.set(last_name, forKey: "userLastName")
                        defaults.synchronize();
                        
                        self.dismiss(animated: true, completion:nil);
                        
                    }
                    
                    if (myStatus == "Error")
                    {
                        self.mess.text = myMessage
                    }
                    
                }
            }
        }
        
        
        
        
        
        
        
        
//        let request = URLRequest(url: url!)
//        let session = URLSession(configuration: URLSessionConfiguration.default)
//        let task = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
//            if error == nil {
//                let swiftyJSON = JSON(data: data!)
//                
//                let myStatus = swiftyJSON["signin"][0]["status"].string!
//                let myMessage = swiftyJSON["signin"][0]["message"].string!
//
//                
//                if (myStatus == "Success")
//                {
//                    let first_name = swiftyJSON["signin"][0]["first_name"].string!
//                    let last_name = swiftyJSON["signin"][0]["last_name"].string!
//                    
//                    let defaults = UserDefaults.standard
////                    if let name = defaults.stringForKey("userNameKey") {
////                        print(name)
////                    }
//                    
//                    defaults.set(true,forKey:"isUserLoggedIn");
//                    defaults.set(first_name, forKey: "userFirstName")
//                    defaults.set(last_name, forKey: "userLastName")
//                    defaults.synchronize();
//                    
//                    self.dismiss(animated: true, completion:nil);
//                    
//                    /*
//                    dispatch_async(dispatch_get_main_queue(), {
//                        
//                        
//                        let myAlert = UIAlertController(title:"Alert", message: myMessage, preferredStyle: UIAlertControllerStyle.Alert);
//                        
//                        let okAction = UIAlertAction(title:"Ok", style:UIAlertActionStyle.Default){ action in
//                            self.dismissViewControllerAnimated(true, completion:nil);
//                        }
//                        
//                        myAlert.addAction(okAction);
//                        self.presentViewController(myAlert, animated:true, completion:nil);
//                        
//                    })
// */
//                }
//                
//                if (myStatus == "Error")
//                {
//                    DispatchQueue.main.async(execute: {
//                        
//                        self.mess.text = myMessage
//                        
//                    })
//                }
//                
//            } else {
//                print("Error url")
//            }
//            
//        }) 
//        task.resume()
        
       
        
        
        
 
        
        
        
        
        
/*
        
        let userEmailStored = NSUserDefaults.standardUserDefaults().stringForKey("userEmail");
        
        let userPasswordStored = NSUserDefaults.standardUserDefaults().stringForKey("userPassword");
        
        if(userEmailStored == userEmail)
        {
            if(userPasswordStored == userPassword)
            {
                // Login is successfull
                NSUserDefaults.standardUserDefaults().setBool(true,forKey:"isUserLoggedIn");
                NSUserDefaults.standardUserDefaults().synchronize();
                
                self.dismissViewControllerAnimated(true, completion:nil);
            }
        }
*/
        
        
    }
}
