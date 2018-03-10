//
//  FirstTabViewController.swift
//  Kogen
//
//  Created by Kogen on 8/11/16.
//  Copyright © 2016 Kogen. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class FirstTabViewController: UIViewController,  UITableViewDataSource, UITableViewDelegate {
  
    var privateListName         = [String]()
    var privateListText         = [String]()
    var privateListImg          = [String]()
    
    @IBOutlet weak var myTableView: UITableView!
    
    var baseURL="http://ksinfo1000.com/backend.php/connect/team"
    
    //@IBOutlet weak var topConstraint: NSLayoutConstraint!
    //@IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.topConstraint.constant = 10
        //self.bottomConstraint.constant = 50
        
        configureTableView()
        
        getJSON()
    }

    
//    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//        if UIDevice.current.orientation.isLandscape {
//            self.topConstraint.constant = 5
//        } else {
//            self.topConstraint.constant = 5
//        }
//    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        

        //print(34)
        //configureTableView()
        
        
        //
        //        var topBar = self.navigationController?.navigationBar.frame.height
        //        var bottomBar = self.tabBarController?.tabBar.frame.height
        //
        //        if UIDevice.current.orientation.isLandscape {
        //            self.tableView.contentInset = UIEdgeInsetsMake(topBar, 0, 50, 0);
        //        } else {
        //            self.tableView.contentInset = UIEdgeInsetsMake(70, 0, 50, 0);
        //        }
    }
    func configureTableView() {
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        //self.tableView.contentInset = UIEdgeInsetsMake(50, 0, 50, 0);
        if let rect = self.navigationController?.navigationBar.frame {
            let y = rect.height
            //let y = rect.size.height + rect.origin.y
            self.myTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        //tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        var returnValue = 0

        returnValue = privateListName.count
        
        return returnValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        tableView.tableFooterView = UIView(frame:CGRect.zero)
        //tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        
        let myCell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! AboutTableViewCell

        myCell.nameView?.text = privateListName[indexPath.row]
        myCell.textView?.text = privateListText[indexPath.row]
        
        if privateListImg[indexPath.row] > "" {
            let url = URL(string: privateListImg[indexPath.row])!
            myCell.imgView.af_setImage(withURL: url)
        }
        else{
            myCell.imgView!.image = UIImage()
        }
        
        //myCell.imgView!.layer.cornerRadius = 40
        myCell.imgView!.layer.masksToBounds = true
        myCell.imgView!.layer.borderColor = UIColor.gray.cgColor
        myCell.imgView!.layer.borderWidth = 0.5

        myCell.imgView!.layer.shadowColor = UIColor.black.cgColor
        myCell.imgView!.layer.shadowOpacity = 1
//        myCell.imgView!.layer.shadowOffset = CGSize.zero
        myCell.imgView!.layer.shadowOffset = CGSize(width: 5, height: 5)
        myCell.imgView!.layer.shadowRadius = 10

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
        
        //let isLandscape = UIDeviceOrientationIsLandscape(currentOrientation);
        //let isPortrait = UIDeviceOrientationIsPortrait(currentOrientation);
        // Rotate your view, or other things here
    }
    
    func getJSON()
    {
        let url = URL(string: baseURL)
        
        self.privateListName = []
        self.privateListImg = []
        self.privateListText = []
        
        Alamofire.request(url!).responseJSON { response in
            if let value = response.result.value as? [String: AnyObject] {
                if let posts = value["team"] as? [[String: AnyObject]]
                {
                    for contacts in posts
                    {

                        if var name = contacts["name"] {
                            self.privateListName.append(name as! String)
                        }
                        if var img = contacts["img"] {
                            self.privateListImg.append(img as! String)
                        }
                        if var text = contacts["text"] {
                            self.privateListText.append(text as! String)
                        }
                    }
                    self.myTableView.reloadData()
                }
            }
        }
    }
}
