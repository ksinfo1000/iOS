//
//  userViewController.swift
//  Kogen
//
//  Created by Kogen on 8/16/16.
//  Copyright © 2016 Kogen. All rights reserved.
//

import UIKit

class userViewController: UIViewController {

    @IBOutlet weak var labelFirstName: UILabel!
    @IBOutlet weak var labelLastName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
//    func switchToViewController(identifier: String) {
//        let viewController = self.storyboard?.instantiateViewControllerWithIdentifier(identifier) as UIViewController
//        self.navigationController?.setViewControllers([viewController], animated: false)
//    }
    
    
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    override var preferredInterfaceOrientationForPresentation : UIInterfaceOrientation {
        return UIInterfaceOrientation.portrait
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        let defaults = UserDefaults.standard
        let isUserLoggedIn = defaults.bool(forKey: "isUserLoggedIn")

        if(!isUserLoggedIn)
        {
            let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LVController")
            self.present(viewController, animated: false, completion: nil)
 
//            self.performSegueWithIdentifier("LoginView", sender: self)

            //let viewController = (self.storyboard?.instantiateViewControllerWithIdentifier("LoginView"))! as UIViewController

            //self.presentViewController(viewController, animated: false, completion: nil)
            
            
            //let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("LoginView") as! UIViewController
//            self.presentViewController(viewController, animated: true, completion: nil)
        }
        
//        if (PFUser.currentUser() == nil) {
//            dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                
//                let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Login") as! UIViewController
//                self.presentViewController(viewController, animated: true, completion: nil)
//            })
//        }
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        let isUserLoggedIn = defaults.bool(forKey: "isUserLoggedIn")
        
        if(!isUserLoggedIn)
        {
            
//            let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("LVController")
//            self.presentViewController(viewController, animated: false, completion: nil)
            
            
            //self.performSegueWithIdentifier("LoginView", sender: self)
            
            
//            let alert = UIAlertController(title: "Order Placed!", message: "Thank you for your order.\nWe'll ship it to you soon!", preferredStyle: .alert)
//            let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {
//                (_)in
//                self.performSegue(withIdentifier: "unwindToMenu", sender: self)
//            })
//            
//            alert.addAction(OKAction)
//            self.present(alert, animated: true, completion: nil)
            
            
            
            
//            let myMessage = "213"
//            let myAlert = UIAlertController(title:"Alert", message: myMessage, preferredStyle: UIAlertControllerStyle.Alert);
//            
//            let okAction = UIAlertAction(title:"Ok", style:UIAlertActionStyle.Default){ action in
//                self.performSegueWithIdentifier("LoginView", sender: nil)
//            }
//            
//            myAlert.addAction(okAction);
//            self.presentViewController(myAlert, animated:true, completion:nil);
            
            
            
        }
        else
        {
            if let first_name = defaults.object(forKey: "userFirstName")
            {
                self.labelFirstName.text = first_name as! String
            }
            if let last_name = defaults.object(forKey: "userLastName")
            {
                self.labelLastName.text = last_name as! String
            }
            
        }

    }
    
    @IBAction func logoutButtonTapped(_ sender: AnyObject) {
        
        let defaults = UserDefaults.standard
        
        defaults.set(false,forKey:"isUserLoggedIn");
        defaults.set("",forKey:"userFirstName");
        defaults.set("",forKey:"userLastName");
        defaults.synchronize();
        
        self.performSegue(withIdentifier: "LoginView", sender: self)
        
    }
    /*
    @IBAction func logoutButtonTapped(sender: AnyObject) {
        
        NSUserDefaults.standardUserDefaults().setBool(false, forKey: "isUserLoggedIn");
        NSUserDefaults.standardUserDefaults().synchronize();
        
        self.performSegueWithIdentifier("LoginView", sender: self);
    }
 */
    
    
}
