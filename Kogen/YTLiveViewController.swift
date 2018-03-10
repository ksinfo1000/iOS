//
//  YTLiveViewController.swift
//  Kogen
//
//  Created by Kogen on 11/9/16.
//  Copyright © 2016 Kogen. All rights reserved.
//

import UIKit
import Alamofire

class YTLiveViewController: UIViewController,YTPlayerViewDelegate{

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var container: UIView!
    
    var baseURL = "http://ksinfo1000.com/backend.php/connect/settings"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if self.revealViewController() != nil {
            revealViewController().rearViewRevealWidth = 270
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        self.title = "Трансляция"
        
        getJSON()
        
    }
    
    func getJSON()
    {
        Alamofire.request("http://ksinfo1000.com/backend.php/connect/settings").responseJSON { response in
            if let value = response.result.value as? [String: AnyObject] {
                if let settings = value["settings"] as? [String: AnyObject]
                {
                    if let myYoutube = settings["youtube"]?.boolValue
                    {
                        if myYoutube == true{
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "liveYesView") as! LiveYesViewController
                            self.container.addSubview(vc.view)
                        }
                        else{
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "noLiveView") as! NoLiveViewController
                            
                            //self.container.hidden = true
                            self.container.addSubview(vc.view)
                        }
                    }
                }
            }
        }
    }
    
//    func getJSON()
//    {
//        let url = URL(string: baseURL)
//        let request = URLRequest(url: url!)
//        let session = URLSession(configuration: URLSessionConfiguration.default)
//        let task = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
//            if error == nil {
//                let swiftyJSON = JSON(data: data!)
//                let myYoutube = swiftyJSON["settings"]["youtube"].bool!
//                DispatchQueue.main.async(execute: {
//                    
//                    if myYoutube == true{
//                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "liveYesView") as! LiveYesViewController
//                        self.container.addSubview(vc.view)
//                    }
//                    else{
//                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "noLiveView") as! NoLiveViewController
//                        
//                        //self.container.hidden = true
//                        self.container.addSubview(vc.view)
//                    }
//                    
//                })
//            } else {
//                print("Error url")
//            }
//            
//        }) 
//        
//        task.resume()
//    }

}
