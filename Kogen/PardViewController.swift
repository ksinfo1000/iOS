//
//  PardViewController.swift
//  Kogen
//
//  Created by Kogen on 12/2/17.
//  Copyright © 2017 KozhenSpromozhen. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class PardViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var myTableViewPard: UITableView!
    
    
    var privateListId         = [String]()
    var privateList         = [String]()
    var privateListViewed       = [Bool]()
    var privateListImg      = [String]()
    var privateListImgFull  = [String]()
    var privateListImgOrigin  = [String]()
    var privateListText     = [String]()
    var privateListDate     = [String]()
    var privateListYoutubeId    = [String]()
    
    var baseURL = "http://ksinfo1000.com/backend.php/connect/pard"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UIApplication.shared.applicationIconBadgeNumber = 0
        self.title = "Новости партнёров"
        
        getJSON()
        
        configureTableView()
        
        if self.revealViewController() != nil {
            revealViewController().rearViewRevealWidth = 300
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        // Do any additional setup after loading the view.
    }
    func configureTableView() {
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        //self.tableView.contentInset = UIEdgeInsetsMake(50, 0, 50, 0);
        if let rect = self.navigationController?.navigationBar.frame {
            let y = rect.height
            //let y = rect.size.height + rect.origin.y
            self.myTableViewPard.contentInset = UIEdgeInsetsMake(y, 0, 50, 0)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        var returnValue = 0
        returnValue = privateList.count
        return returnValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCellPard", for: indexPath) as! PardTableViewCell
        
        cell.nameLabel?.text = privateList[indexPath.row]
        cell.myDate?.text    = privateListDate[indexPath.row]
        
        if privateListImg[indexPath.row] > "" {
            let url = URL(string: privateListImg[indexPath.row])!
            cell.thumbnailImageView.af_setImage(withURL: url)
        }
        else{
            cell.thumbnailImageView!.image = UIImage()
        }
        
        if privateListViewed[indexPath.row] == true{
            cell.backgroundColor = UIColor(white: 1, alpha: 1.0)
        }
        else {
            cell.backgroundColor = UIColor(red: 1.0, green: 216/255, blue: 216/255, alpha: 0.7)
            //ffd8d8
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var selectedCell = tableView.cellForRow(at: indexPath as IndexPath)!
        if let myCell = tableView.cellForRow(at: indexPath) as? PardTableViewCell {
            myCell.backgroundColor = UIColor(white: 1, alpha: 0.5)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailsPardShow" {
            if let indexPath = myTableViewPard.indexPathForSelectedRow {
                let destinationController = segue.destination as! detailPardViewController
                destinationController.detailId = privateListId[indexPath.row]
                destinationController.detailName = privateList[indexPath.row]
                destinationController.detailImage = privateListImgFull[indexPath.row]
                destinationController.detailImageOrigin = privateListImgOrigin[indexPath.row]
                destinationController.detailText = privateListText[indexPath.row]
                destinationController.detailDate = privateListDate[indexPath.row]
                destinationController.detailYoutubeId = privateListYoutubeId[indexPath.row]
            }
        }
    }
    
    func getJSON()
    {
        self.privateListId = []
        self.privateList = []
        self.privateListViewed = []
        self.privateListImg = []
        self.privateListImgFull = []
        self.privateListImgOrigin = []
        self.privateListText = []
        self.privateListDate = []
        self.privateListYoutubeId = []
        
        let deviceID = UIDevice.current.identifierForVendor!.uuidString
        let baseURLw = baseURL + "?device_id=" + deviceID

        Alamofire.request(baseURLw).responseJSON { response in
            if let value = response.result.value as? [String: AnyObject] {
                if let posts = value["pards"] as? [[String: AnyObject]]
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
                        if var text = contacts["text"] {
                            self.privateListText.append(text as! String)
                        }
                        if var date = contacts["date"] {
                            self.privateListDate.append(date as! String)
                        }
                        if var youtube_id = contacts["youtube_id"] {
                            self.privateListYoutubeId.append(youtube_id as! String)
                        }
                        if var viewed = contacts["viewed"]?.boolValue {
                            self.privateListViewed.append(viewed as! Bool)
                        }
                    }
                    self.myTableViewPard.reloadData()
                }
            }
        }
    }
}
