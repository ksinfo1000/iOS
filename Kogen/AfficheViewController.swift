//
//  AfficheViewController.swift
//  Kogen
//
//  Created by Kogen on 7/27/16.
//  Copyright © 2016 Kogen. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class AfficheViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var mySegmentegControlAffiche: UISegmentedControl!
    @IBOutlet weak var myTableViewAffiche: UITableView!
    
    var privateListId           = [String]()
    var privateList             = [String]()
    var privateListViewed       = [Bool]()
    var privateListImg          = [String]()
    var privateListImgFull      = [String]()
    var privateListImgOrigin    = [String]()
    var privateListCity         = [String]()
    var privateListText         = [String]()
    var privateListDate         = [String]()
    var privateListTime         = [String]()
    var privateListAddress      = [String]()
    var privateListYoutubeId    = [String]()
    
    var baseURL = "http://ksinfo1000.com/backend.php/connect/affiche"
    let baseImg = "http://ksinfo1000.com/uploads/pic.png"
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func cancel(_ sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        configureTableView()

//        var topBar = self.navigationController?.navigationBar.frame.height
//        var bottomBar = self.tabBarController?.tabBar.frame.height
//        
//        if UIDevice.current.orientation.isLandscape {
//            self.tableView.contentInset = UIEdgeInsetsMake(topBar, 0, 50, 0);
//        } else {
//            self.tableView.contentInset = UIEdgeInsetsMake(70, 0, 50, 0);
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Add a background view to the table view
        let backgroundImage = UIImage(named: "luxfon.com_1.jpg")
        let imageView = UIImageView(image: backgroundImage)
        imageView.contentMode = .scaleAspectFill
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = imageView.bounds
        imageView.addSubview(blurView)
        
        self.myTableViewAffiche.backgroundView = imageView
        self.myTableViewAffiche.backgroundColor = .lightGray
        
    }
    
    func configureTableView() {
        self.automaticallyAdjustsScrollViewInsets = false
        //self.tableView.contentInset = UIEdgeInsetsMake(50, 0, 50, 0);
        if let rect = self.navigationController?.navigationBar.frame {
            let y = rect.height
            //let y = rect.size.height + rect.origin.y
            self.tableView.contentInset = UIEdgeInsetsMake(y, 0, 50, 0)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.applicationIconBadgeNumber = 0

        configureTableView()
        
        getParsing()
        
        if self.revealViewController() != nil {
            revealViewController().rearViewRevealWidth = 270
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        var returnValue = 0
        
        switch(mySegmentegControlAffiche.selectedSegmentIndex)
        {
        case 0:
            self.title = "Концерты"
            returnValue = privateList.count
            break
        case 1:
            self.title = "Семинары"
            returnValue = privateList.count
            break
        default:
            break
        }
        returnValue = privateList.count
        return returnValue
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! AfficheTableViewCell
        myCell.nameLabel?.text      = privateList[indexPath.row]
        myCell.cityLabel?.text      = privateListCity[indexPath.row]
        myCell.timeLabel?.text      = privateListTime[indexPath.row]
        myCell.dateLabel?.text      = privateListDate[indexPath.row]
        myCell.addressLabel?.text   = privateListAddress[indexPath.row]
        
        
        if privateListImg[indexPath.row] > "" {
            let url = URL(string: privateListImg[indexPath.row])!
            myCell.thumbnailImageView.af_setImage(withURL: url)
        }
        else{
            myCell.thumbnailImageView!.image = UIImage()
        }
        
        myCell.backgroundColor = UIColor(white: 1, alpha: 0.5)
        
        
        if privateListViewed[indexPath.row] == true{
            myCell.backgroundColor = UIColor(white: 1, alpha: 0.5)
        }
        else {
            myCell.backgroundColor = UIColor(red: 1.0, green: 216/255, blue: 216/255, alpha: 0.7)
            //ffd8d8
        }
        
        return myCell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var selectedCell = tableView.cellForRow(at: indexPath as IndexPath)!
        if let myCell = tableView.cellForRow(at: indexPath) as? AfficheTableViewCell {
            myCell.backgroundColor = UIColor(white: 1, alpha: 0.5)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {

            if let indexPath = tableView.indexPathForSelectedRow {
              let destinationController = segue.destination as! detailViewController
                destinationController.detailId = privateListId[indexPath.row]
                destinationController.detailСity = privateListCity[indexPath.row]
                destinationController.detailName = privateList[indexPath.row]
                destinationController.detailImage = privateListImgFull[indexPath.row]
                destinationController.detailImageOrigin = privateListImgOrigin[indexPath.row]
                destinationController.detailDate = privateListDate[indexPath.row]
                destinationController.detailTime = privateListTime[indexPath.row]
                destinationController.detailAddress = privateListAddress[indexPath.row]
                destinationController.detailText = privateListText[indexPath.row]
                destinationController.detailYoutubeId = privateListYoutubeId[indexPath.row]
            }
        }
    }
    
    func getParsing()
    {
        var returnValue = 0
        
        switch(mySegmentegControlAffiche.selectedSegmentIndex)
        {
        case 0:
            returnValue = 1
            break
        case 1:
            returnValue = 2
            break
        default:
            break
        }
        
        let deviceID = UIDevice.current.identifierForVendor!.uuidString
        let baseURLw = baseURL + "?category=" + String(returnValue) + "&device_id=" + deviceID
        
        self.privateList = []
        self.privateListViewed = []
        self.privateListImg = []
        self.privateListImgFull = []
        self.privateListImgOrigin = []
        self.privateListCity = []
        self.privateListDate = []
        self.privateListTime = []
        self.privateListAddress = []
        self.privateListText = []
        self.privateListYoutubeId = []
        
        
        
        Alamofire.request(baseURLw).responseJSON { response in
            if let value = response.result.value as? [String: AnyObject] {
                if let posts = value["concerts"] as? [[String: AnyObject]]
                {
                    for contacts in posts
                    {
                        if var id = contacts["id"] {
                            self.privateListId.append(id as! String)
                        }
                        if var name = contacts["name"] {
                            self.privateList.append(name as! String)
                        }
                        if var img = contacts["img"] {
                            self.privateListImg.append(img as! String)
                        }
                        if var img_full = contacts["img_full"] {
                            self.privateListImgFull.append(img_full as! String)
                        }
                        if var img_origin = contacts["img_origin"] {
                            self.privateListImgOrigin.append(img_origin as! String)
                        }
                        if var city = contacts["city"] {
                            self.privateListCity.append(city as! String)
                        }
                        if var text = contacts["text"] {
                            self.privateListText.append(text as! String)
                        }
                        if var date = contacts["date"] {
                            self.privateListDate.append(date as! String)
                        }
                        if var time = contacts["time"] {
                            self.privateListTime.append(time as! String)
                        }
                        if var address = contacts["address"] {
                            self.privateListAddress.append(address as! String)
                        }
                        if var youtube_id = contacts["youtube_id"] {
                            self.privateListYoutubeId.append(youtube_id as! String)
                        }
                        if var viewed = contacts["viewed"]?.boolValue {
                            self.privateListViewed.append(viewed as! Bool)
                        }
                    }
                    self.myTableViewAffiche.reloadData()
                }
            }
        }
    }
    
    @IBAction func refreshButtonTapped(_ sender: AnyObject) {
        getParsing()
        myTableViewAffiche.reloadData()
    }
    
    @IBAction func segmentedControlActionChanged(_ sender: AnyObject) {
        getParsing()
        myTableViewAffiche.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
