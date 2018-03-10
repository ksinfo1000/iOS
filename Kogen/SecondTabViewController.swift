//
//  SecondTabViewController.swift
//  Kogen
//
//  Created by Kogen on 8/11/16.
//  Copyright © 2016 Kogen. All rights reserved.
//

import UIKit
import Alamofire

class SecondTabViewController: UIViewController,  UITableViewDataSource, UITableViewDelegate {

    var privateListName         = [String]()
    //var privateListText         = [String]()
    var privateListImg          = [String]()
    
    @IBOutlet weak var myTableView: UITableView!
    
    var baseURL="http://ksinfo1000.com/backend.php/connect/partners"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getJSON()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        var returnValue = 0
        
        returnValue = privateListName.count
        
        return returnValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        tableView.tableFooterView = UIView(frame:CGRect.zero)
        
        let myCell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! AboutTableViewCellPartner
        
        //myCell.nameView?.text = privateListName[indexPath.row]
        //myCell.textView?.text = privateListText[indexPath.row]
        
        if privateListImg[indexPath.row] > "" {
            let url = URL(string: privateListImg[indexPath.row])!
            myCell.imgView.af_setImage(withURL: url)
        }
        else{
            myCell.imgView!.image = UIImage()
        }
        
        return myCell
    }
    
    /*
     override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: 100) {
     let indexPath = tableView.indexPathsForVisibleRows![0]
     tableView.scrollToRow(at: indexPath, at: UITableViewScrollPosition.top, animated: false)
     }
     */
    func deviceDidRotate(_ notification: Notification) {
        let currentOrientation = UIDevice.current.orientation
        
        // Ignore changes in device orientation if unknown, face up, or face down.
        if !UIDeviceOrientationIsValidInterfaceOrientation(currentOrientation) {
            return;
        }
        
        let isLandscape = UIDeviceOrientationIsLandscape(currentOrientation);
        let isPortrait = UIDeviceOrientationIsPortrait(currentOrientation);
        // Rotate your view, or other things here
    }
    
    func getJSON()
    {
        let url = URL(string: baseURL)
        
        self.privateListName = []
        self.privateListImg = []
        
        Alamofire.request(url!).responseJSON { response in
            if let value = response.result.value as? [String: AnyObject] {
                if let posts = value["partners"] as? [[String: AnyObject]]
                {
                    for contacts in posts
                    {
                        
                        if var name = contacts["name"] {
                            self.privateListName.append(name as! String)
                        }
                        if var img = contacts["img"] {
                            self.privateListImg.append(img as! String)
                        }
                    }
                    self.myTableView.reloadData()
                }
            }
        }
    }
    
//    func getJSON()
//    {
//        let url = URL(string: baseURL)
//        let request = URLRequest(url: url!)
//        let session = URLSession(configuration: URLSessionConfiguration.default)
//        
//        let task = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
//            if error == nil {
//                let swiftyJSON = JSON(data: data!)
//                let privateListArray = swiftyJSON["partners"].arrayValue
//                DispatchQueue.main.async(execute: {
//                    for contacts in privateListArray
//                    {
//                        let name        = contacts["name"].stringValue
//                        //let text        = contacts["text"].stringValue
//                        let img         = contacts["img"].stringValue
//                        //print(img)
//                        self.privateListName.append(name)
//                        //self.privateListText.append(text)
//                        self.privateListImg.append(img)
//                        
//                        
//                        DispatchQueue.main.async(execute: {
//                            self.myTableView.reloadData()
//                        })
//                        
//                    }
//                    
//                })
//                
//            } else {
//                print("Error url")
//            }
//            
//        }) 
//        task.resume()
//    }
    
}
