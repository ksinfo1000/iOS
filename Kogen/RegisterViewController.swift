//
//  RegisterViewController.swift
//  Kogen
//
//  Created by Kogen on 8/16/16.
//  Copyright © 2016 Kogen. All rights reserved.
//

import UIKit
import Alamofire

class RegisterViewController: UIViewController {

    
    var baseURL = "http://ksinfo1000.com/backend.php/connect/registration"
    
    var email_address = ""
    var password = ""
    var first_name = ""
    var second_name = ""
    
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    @IBOutlet weak var userFirstNameTextField: UITextField!
    @IBOutlet weak var userSecondNameTextField: UITextField!
    
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    @IBOutlet weak var mess: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assignbackground()
        UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
    }
    
    
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    override var preferredInterfaceOrientationForPresentation : UIInterfaceOrientation {
        return UIInterfaceOrientation.portrait
    }
    
    func assignbackground(){
        let background = UIImage(named: "luxfon.com_1")
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIViewContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = imageView.bounds
        imageView.addSubview(blurView)
        
        view.addSubview(imageView)
        self.view.sendSubview(toBack: imageView)
    }
   


    @IBAction func registerButtonTapped(_ sender: AnyObject) {
        
        var userEmail = "";
        if let userEmailF = userEmailTextField.text {
            userEmail = userEmailF
        }

        var userPassword = "";
        if let userPasswordF = userPasswordTextField.text {
            userPassword = userPasswordF
        }

        var userFirstName = "";
        if let userFirstNameF = userFirstNameTextField.text {
            userFirstName = userFirstNameF
        }

        var userSecondName = "";
        if let userSecondNameF = userSecondNameTextField.text {
            userSecondName = userSecondNameF
        }
        
        let userRepeatPassword = repeatPasswordTextField.text;
        
        //Display Registration Confirmation
        func displayMyAlertMessage(_ userMessage:String)
        {
            let myAlert = UIAlertController(title: "Alert", message: "Registration Successful", preferredStyle: UIAlertControllerStyle.alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { action in
                self.dismiss(animated: true, completion: nil)
            }
            
            myAlert.addAction(okAction);
            self.present(myAlert, animated: true, completion: nil);
        }
/*
        // Check for empty fields
        if(userEmail!.isEmpty || userPassword!.isEmpty || userRepeatPassword!.isEmpty)
        {
            // Display alert message
            displayMyAlertMessage("Заполните все поля");
            return;
        }
*/
        //Check if passwords match
        if(userPassword != userRepeatPassword)
        {
            // Display an alert message
            displayMyAlertMessage("Пароли не совпадают");
            return;
            
        }

        if let email_address1 = userEmail.addingPercentEscapes(using: String.Encoding.utf8) {
            email_address = email_address1
        }
        if let password1 = userPassword.addingPercentEscapes(using: String.Encoding.utf8) {
            password = password1
        }
        if let first_name1 = userFirstName.addingPercentEscapes(using: String.Encoding.utf8) {
            first_name = first_name1
        }
        if let second_name1 = userSecondName.addingPercentEscapes(using: String.Encoding.utf8) {
            second_name = second_name1
        }

        let baseURLw = baseURL + "?email_address=\(email_address)&password=\(password)&first_name=\(first_name)&last_name=\(second_name)"
        
        
        let url = URL(string: baseURLw)
        
        var myStatus = ""
        var myMessage = ""
        
        Alamofire.request(url!).responseJSON { response in
            if let value = response.result.value as? [String: AnyObject] {
                if let registration = value["registration"] as? [String: AnyObject]
                {
                    if (registration["status"] != nil)
                    {
                        myStatus = registration["status"] as! String
                    }
                    if (registration["message"] != nil)
                    {
                        myMessage = registration["message"] as! String
                    }
                    
                    if (myStatus == "Success")
                    {
                        let myAlert = UIAlertController(title:"Alert", message: myMessage, preferredStyle: UIAlertControllerStyle.alert);
                        
                        let okAction = UIAlertAction(title:"Ok", style:UIAlertActionStyle.default){ action in
                            self.dismiss(animated: true, completion:nil);
                        }
                        
                        myAlert.addAction(okAction);
                        self.present(myAlert, animated:true, completion:nil);
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
//                let myStatus = swiftyJSON["registration"][0]["status"].string!
//                let myMessage = swiftyJSON["registration"][0]["message"].string!
//                
//                if (myStatus == "Success")
//                {
//                    DispatchQueue.main.async(execute: {
//                        
//                        let myAlert = UIAlertController(title:"Alert", message: myMessage, preferredStyle: UIAlertControllerStyle.alert);
//                        
//                        let okAction = UIAlertAction(title:"Ok", style:UIAlertActionStyle.default){ action in
//                            self.dismiss(animated: true, completion:nil);
//                        }
//                        
//                        myAlert.addAction(okAction);
//                        self.present(myAlert, animated:true, completion:nil);
//
//                    })
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
//        
//        task.resume()
        
        // Store data
 /*
        NSUserDefaults.standardUserDefaults().setObject(userEmail, forKey: "userEmail");
        NSUserDefaults.standardUserDefaults().setObject(userPassword, forKey: "userPassword");
        NSUserDefaults.standardUserDefaults().setObject(userRepeatPassword, forKey: "userRepeatPassword");
        
        NSUserDefaults.standardUserDefaults().synchronize();
 */
        


    }
    
    
    @IBAction func iHaveAnAccountButtonTapped(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }

}
