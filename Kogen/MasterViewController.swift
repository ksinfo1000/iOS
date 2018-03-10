//
//  MasterViewController.swift
//  Kogen
//
//  Created by Kogen on 7/28/16.
//  Copyright © 2016 Kogen. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import Firebase
import FirebaseMessaging

class MasterViewController: UITableViewController {

   // var searchController: UISearchController!
    
    @IBOutlet var mainTable: UITableView!
//    @IBOutlet weak var cellLive: UITableViewCell!
//    @IBOutlet weak var textLive: UILabel!
//    @IBOutlet weak var imageLive: UIImageView!
    
    @IBOutlet weak var imageVote: UIImageView!
    @IBOutlet weak var labelVote: UILabel!
    
//    @IBOutlet weak var afficheCell: UITableViewCell!
    
    
//    @IBOutlet weak var afficheBadgeLabel: UILabel!
//    @IBOutlet weak var pardBadgeLabel: UILabel!
    @IBOutlet weak var section_1_badgeLabel: UILabel!
    @IBOutlet weak var section_2_badgeLabel: UILabel!
    @IBOutlet weak var section_3_badgeLabel: UILabel!
    @IBOutlet weak var section_4_badgeLabel: UILabel!
    @IBOutlet weak var section_5_badgeLabel: UILabel!
    
    
    var baseURL = "http://ksinfo1000.com/backend.php/connect/settings"
    
    @IBOutlet weak var voteCell: UITableViewCell!
    
    @IBAction func GoogleButton(_ sender: AnyObject) {
        if let url = URL(string: "https://www.facebook.com/kozhenspromozhen"){
            UIApplication.shared.openURL(url)
        }
    }
    
    @IBAction func YoutubeButton(_ sender: AnyObject) {
        if let url = URL(string: "https://www.youtube.com/channel/UCSi6tIbFMetc8wfDizW9spg"){
            UIApplication.shared.openURL(url)
        }
    }
    
    @IBAction func InstagramButton(_ sender: AnyObject) {
        if let url = URL(string: "https://www.instagram.com/kozhen_spromozhen/"){
            UIApplication.shared.openURL(url)
        }
    }
    
    
    @IBAction func TwitterButton(_ sender: AnyObject) {
        if let url = URL(string: "https://twitter.com/spromozhen"){
            UIApplication.shared.openURL(url)
        }
    }
    
    var deviceID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

/*
        self.afficheBadgeLabel.layer.cornerRadius = 10.0
        self.afficheBadgeLabel.clipsToBounds = true
        self.afficheBadgeLabel.text = ""
        self.afficheBadgeLabel.layer.isHidden = true
        
        self.pardBadgeLabel.layer.cornerRadius = 10.0
        self.pardBadgeLabel.clipsToBounds = true
        self.pardBadgeLabel.text = ""
        self.pardBadgeLabel.layer.isHidden = true
*/
//        self.section_1_badgeLabel.layer.cornerRadius = 10.0
        self.section_1_badgeLabel.clipsToBounds = true
        self.section_1_badgeLabel.text = ""
        //self.section_1_badgeLabel.textColor = UIColor(red: 223.0/255.0, green: 193.0/255.0, blue: 31.0/255.0, alpha: 1.0)
        self.section_1_badgeLabel.layer.isHidden = true
        
        
//        self.section_2_badgeLabel.layer.cornerRadius = 10.0
        self.section_2_badgeLabel.clipsToBounds = true
        self.section_2_badgeLabel.text = ""
        self.section_2_badgeLabel.layer.isHidden = true
        
//        self.section_3_badgeLabel.layer.cornerRadius = 10.0
        self.section_3_badgeLabel.clipsToBounds = true
        self.section_3_badgeLabel.text = ""
        self.section_3_badgeLabel.layer.isHidden = true
        
//        self.section_4_badgeLabel.layer.cornerRadius = 10.0
        self.section_4_badgeLabel.clipsToBounds = true
        self.section_4_badgeLabel.text = ""
        self.section_4_badgeLabel.layer.isHidden = true
        
//        self.section_5_badgeLabel.layer.cornerRadius = 10.0
        self.section_5_badgeLabel.clipsToBounds = true
        self.section_5_badgeLabel.text = ""
        self.section_5_badgeLabel.layer.isHidden = true
        
        let defaults = UserDefaults.standard
        
        var sectionPushId = ""
        
        if let sectionPush = defaults.string(forKey: "sectionPush"){
            sectionPushId = sectionPush
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getJSON()
    }
    
    func imageWithImage(image:UIImage,scaledToSize newSize:CGSize)->UIImage{
        UIGraphicsBeginImageContext( newSize )
        image.draw(in: CGRect(x: 0,y: 5,width: newSize.width-10,height: newSize.height-10))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
       // UIGraphicsEndImageContext()
        return newImage!
    }
    
    func getJSON()
    {
        self.deviceID = UIDevice.current.identifierForVendor!.uuidString
        
        Alamofire.request("http://ksinfo1000.com/backend.php/connect/settings?device_id="+self.deviceID).responseJSON { response in
            if let value = response.result.value as? [String: AnyObject] {
                if let settings = value["settings"] as? [String: AnyObject]
                {
                    if let myVotePublic = settings["vote_public"]?.boolValue
                    {
                        if myVotePublic == true {
                            self.voteCell.isHidden = false
                            if let name = settings["contest_name"] {
                                self.labelVote?.text = name as? String
                            }
                            if let image = settings["contest_img"] {
                                let url = URL(string: image as! String)!
                                self.imageVote?.af_setImage(withURL: url)
                            }

                        }
                        else{
                            self.voteCell.isHidden = true
                        }
                    }

/*
                    if let count_news = settings["count_news"] {
                        if count_news as! NSNumber != 0 {
                            
                            self.afficheBadgeLabel.layer.isHidden = false
                            self.afficheBadgeLabel.text = "\(count_news)"
                        }
                        else {
                            self.afficheBadgeLabel.layer.isHidden = true
                            self.afficheBadgeLabel.text = ""
                        }
                    }

                    if let count_pard = settings["count_pard"] {
                        if count_pard as! NSNumber != 0 {
                            self.pardBadgeLabel.layer.isHidden = false
                            self.pardBadgeLabel.text = "\(count_pard)"
                        }
                        else {
                            self.pardBadgeLabel.layer.isHidden = true
                            self.pardBadgeLabel.text = ""
                        }
                    }
*/

                    if let count_section_news_1 = settings["count_section_news_1"] {
                        if count_section_news_1 as! NSNumber != 0 {
                            self.section_1_badgeLabel.layer.isHidden = false
                            self.section_1_badgeLabel.text = "\(count_section_news_1)"
                        }
                        else {
                            self.section_1_badgeLabel.layer.isHidden = true
                            self.section_1_badgeLabel.text = ""
                        }
                    }
                    if let count_section_news_2 = settings["count_section_news_2"] {
                        if count_section_news_2 as! NSNumber != 0 {
                            self.section_2_badgeLabel.layer.isHidden = false
                            self.section_2_badgeLabel.text = "\(count_section_news_2)"
                        }
                        else {
                            self.section_2_badgeLabel.layer.isHidden = true
                            self.section_2_badgeLabel.text = ""
                        }
                    }
                    if let count_section_news_3 = settings["count_section_news_3"] {
                        if count_section_news_3 as! NSNumber != 0 {
                            self.section_3_badgeLabel.layer.isHidden = false
                            self.section_3_badgeLabel.text = "\(count_section_news_3)"
                        }
                        else {
                            self.section_3_badgeLabel.layer.isHidden = true
                            self.section_3_badgeLabel.text = ""
                        }
                    }
                    if let count_section_news_4 = settings["count_section_news_4"] {
                        if count_section_news_4 as! NSNumber != 0 {
                            self.section_4_badgeLabel.layer.isHidden = false
                            self.section_4_badgeLabel.text = "\(count_section_news_4)"
                        }
                        else {
                            self.section_4_badgeLabel.layer.isHidden = true
                            self.section_4_badgeLabel.text = ""
                        }
                    }
                    if let count_section_news_5 = settings["count_section_news_5"] {
                        if count_section_news_5 as! NSNumber != 0 {
                            self.section_5_badgeLabel.layer.isHidden = false
                            self.section_5_badgeLabel.text = "\(count_section_news_5)"
                        }
                        else {
                            self.section_5_badgeLabel.layer.isHidden = true
                            self.section_5_badgeLabel.text = ""
                        }
                    }
                    
                    /*
                    if let myYoutube = settings["youtube"]?.boolValue
                    {
                        if myYoutube == true{
                            self.cellLive.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
                            self.textLive.textColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                            self.imageLive.image=UIImage(named: "pic_live.png")
                        }
                        else{
                            self.cellLive.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                            self.textLive.textColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.3)
                            self.imageLive.image=UIImage(named: "pic_live_0.png")
                        }
                    }
 */
                }
            }
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let defaults = UserDefaults.standard
        defaults.set(indexPath.row, forKey: "indexPathMain")

        getJSON()
    }
    
}
