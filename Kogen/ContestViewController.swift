//
//  СontestViewController.swift
//  KozhenSpromozhen
//
//  Created by Kogen on 7/12/17.
//  Copyright © 2017 KozhenSpromozhen. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import FacebookLogin
import FacebookCore

class ContestViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var contestTable: UITableView!
    
    @IBOutlet weak var presentTextContest: UILabel!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var presentImageContext: UIImageView!
    
    let list = ["Milk", "Horney", "Bread", "Tacos"]
    
    var privateListId           = [String]()
    var privateListName         = [String]()
    var privateListImg          = [String]()
    var privateListBan          = [String]()
    
    var user_id = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if AccessToken.current != nil {
            let defaults = UserDefaults.standard
            if let fb_user_id = defaults.string(forKey: "fb_user_id"){
                user_id = fb_user_id
            }
        }
        //configureUILabel()
        
        parseContest()
        parseNomination()
        
        if self.revealViewController() != nil {
            revealViewController().rearViewRevealWidth = 300
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
//        contestTable.tableFooterView = UIView()
//        contestTable.tableHeaderView = UIView()
//        let header: MyHeaderView = MyHeaderView.createHeaderView()
//        header.setNeedsUpdateConstraints()
//        header.updateConstraintsIfNeeded()
//        header.frame = CGRectMake(0, 0, CGRectGetWidth(tableView.bounds), CGFloat.max)
//        var newFrame = header.frame
//        header.setNeedsLayout()
//        header.layoutIfNeeded()
//        let newSize = header.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
//        newFrame.size.height = newSize.height
//        header.frame = newFrame
//        self.tableView.tableHeaderView = header
//        if let headerView = contestTable.tableHeaderView {
//            let height = headerView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
//            var frame = headerView.frame
//            frame.size.height = 0
//            headerView.frame = frame
//            contestTable.tableHeaderView = headerView
//            headerView.setNeedsLayout()
//            headerView.layoutIfNeeded()
//        }
        
        
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
    
        return(privateListId.count)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contestCell", for: indexPath) as! ContestTableViewCell

        cell.nameContest?.text = privateListName[indexPath.row]
        
        let url = URL(string: privateListImg[indexPath.row])!
        cell.imageContest.af_setImage(withURL: url)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "show_members2" {
            if let indexPath = contestTable.indexPathForSelectedRow {
                let memberController = segue.destination as! ExpandingViewController
                memberController.nominationId = privateListId[indexPath.row]
                memberController.title = privateListName[indexPath.row]
                memberController.indexBun = privateListBan[indexPath.row].characters.count > 0 ? 1 : 0
                memberController.my_segue = 1
                
                //memberController.my_back_title = self.title!
                
            }
        }
    }

    func parseContest()
    {
        Alamofire.request("http://ksinfo1000.com/backend.php/connect/contest").responseJSON { response in
            if let value = response.result.value as? [String: AnyObject] {
                if let contest = value["contest"] as? [String: AnyObject]
                {
                    if let name = contest["name"] {
                        self.title = name as? String
                    }
                    if let image = contest["img"] {

                        let data = try? Data(contentsOf: URL(string: image as! String)!)
                        let myImage = UIImage(data:data!)
                        self.presentImageContext!.image = myImage
                        
                        
                    }
                    if let text = contest["text"] {
                        self.presentTextContest?.text = text.replacingOccurrences(of: "\\n", with: "\n")
                    }
                }
            }
        }
    }
    
    func parseNomination()
    {
        let nominationURL = "http://ksinfo1000.com/backend.php/connect/nomination?user_id=" + self.user_id
        
        self.privateListId = []
        self.privateListName = []
        self.privateListImg = []
        self.privateListBan = []
        
        Alamofire.request(nominationURL).responseJSON { response in
            if let value = response.result.value as? [String: AnyObject] {
                if let items = value["nomination"] as? [[String: AnyObject]]
                {
                    for item in items
                    {
                        if var id = item["id"] {
                            self.privateListId.append(id as! String)
                        }
                        if var name = item["name"] {
                            self.privateListName.append(name as! String)
                        }
                        if var img = item["img"] {
                            self.privateListImg.append(img as! String)
                        }
                        if var ban = item["ban"] {
                            self.privateListBan.append(ban as! String)
                        }
                    }
                    self.contestTable.reloadData()
                }
            }
        }
    }
    
    func configureUILabel()
    {
        presentTextContest.layer.cornerRadius = 30
        presentTextContest.layer.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 180/255, alpha: 1).cgColor
    }
    
}
