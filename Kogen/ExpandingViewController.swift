//
//  ExpandingViewController.swift
//  KozhenSpromozhen
//
//  Created by Kogen on 7/14/17.
//  Copyright © 2017 KozhenSpromozhen. All rights reserved.
//

import UIKit
import Alamofire
import FacebookLogin
import FacebookCore

class ExpandingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, YTPlayerViewDelegate {

    let cellId = "cellExp"
    
    var nominationId = String()
    
    var privateListId           = [String]()
    var privateListName         = [String]()
    var privateListImg          = [String]()
    var privateListText         = [String]()
    var privateListBun          = [String]()
    var privateListYoutubeId    = [String]()
    var privateListCountVote    = [String()]
    var privateListPresent      = [String()]
    var privateListVote         = [String()]

    var selectedIndex:IndexPath?
    
    var indexBun = 0
    
    var user_id = ""
    
    var isExpanded = false
    
    var may_get_selected: IndexPath?
    
    var my_segue = 0
    
    //var my_back_title = ""
    
    @IBOutlet weak var expTable: UITableView!
    @IBOutlet weak var expandTable: UITableView!
    
    var cells: PickerTableViewCell!
    
    var myClass : LibViewController! = LibViewController()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        myClass.setFBUser()

        if AccessToken.current != nil {
            let defaults = UserDefaults.standard
            if let fb_user_id = defaults.string(forKey: "fb_user_id"){
                user_id = fb_user_id
            }
        }
        
        self.expTable.isHidden = true

        parseMembers()
        
        self.expandTable.tableFooterView = UIView()
        
        //self.navigationItem.backBarButtonItem?.title = my_back_title
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if AccessToken.current != nil && self.my_segue == 0 {
            let defaults = UserDefaults.standard
            if let fb_user_id = defaults.string(forKey: "fb_user_id"){
                user_id = fb_user_id
                parseMembers()
            }
        }
        self.my_segue = 0
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return(privateListId.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! PickerTableViewCell
        
        cell.titleLabel.text = privateListName[indexPath.row]

        cell.countVoteLabel.text = "Всего голосов - " + privateListCountVote[indexPath.row]
        
        let data = try? Data(contentsOf: URL(string: privateListImg[indexPath.row])!)
        let myImage = UIImage(data:data!)
        cell.personImage!.image = myImage
        cell.personImage!.setRounded(radius: 0.5)

        cell.personText.text = ""
        //cell.voteImage.isHidden = true
        if indexBun != 0 || privateListBun[indexPath.row].characters.count > 0 {
            cell.voteButton1.isHidden = true
            if(privateListVote[indexPath.row].characters.count>0) {
                ///cell.accessoryType = .checkmark
                //cell.voteImage.image
                cell.voteImage.isHidden = false
            }
            else {
                cell.voteImage.isHidden = true
            }
        }
        else{
            cell.voteButton1.tag = indexPath.row
            cell.voteButton1.addTarget(self, action: #selector(onButtonPressed(sender :)), for: .touchUpInside)
            cell.voteImage.isHidden = true
        }

        self.expTable.isHidden = false
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        var selectedCell = expTable.cellForRow(at: indexPath as IndexPath)!
        
        //selectedCell.accessoryType = .checkmark
        
        self.selectedIndex = indexPath
        self.didExpandCell()

        if var newIndexPath = self.may_get_selected
        {
            if let cell1 = tableView.cellForRow(at: newIndexPath) as? PickerTableViewCell {
                cell1.player.stopVideo()
            }
        }

        if let cell = tableView.cellForRow(at: indexPath) as? PickerTableViewCell {
            cell.personText.text = privateListText[indexPath.row]
            cell.player.stopVideo()

            if privateListYoutubeId[indexPath.row].characters.count > 0 {
                if(self.isExpanded && self.selectedIndex == indexPath){
                    cell.player.isHidden = false
                    cell.privateListPresent.isHidden = true
                    cell.player.load(withVideoId: privateListYoutubeId[indexPath.row])
                }
                else {
                    cell.player.isHidden = true
                    if privateListPresent[indexPath.row].characters.count > 0 {
                        cell.privateListPresent.isHidden = false
                        let data_present = try? Data(contentsOf: URL(string: privateListPresent[indexPath.row])!)
                        let myImagePresent = UIImage(data:data_present!)
                        cell.privateListPresent!.image = myImagePresent
                    }
                }
            }
            else {
                    cell.player.isHidden = true
                    if privateListPresent[indexPath.row].characters.count > 0 {
                        cell.privateListPresent.isHidden = false
                        let data_present = try? Data(contentsOf: URL(string: privateListPresent[indexPath.row])!)
                        let myImagePresent = UIImage(data:data_present!)
                        cell.privateListPresent!.image = myImagePresent
                    }
            }
        }

        self.may_get_selected = indexPath
    }
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        var selectedCell = expTable.cellForRow(at: indexPath as IndexPath)!
//        selectedCell.accessoryType = .none
//    }
    

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if isExpanded && self.selectedIndex == indexPath{
            return 500
        }
        return 70
    }
    
    func didExpandCell(){
        self.isExpanded = !isExpanded
        self.expTable.reloadRows(at: [selectedIndex!], with: .automatic)
    }
    
    func onButtonPressed(sender:UIButton) {
        
        var alert_title = ""
        var myname_var = self.privateListName[sender.tag]
        
        var result = 0
        
        alert_title = AccessToken.current != nil ? myname_var : "Вы не авторизированы"
        let alert = UIAlertController.init(title: alert_title, message: nil, preferredStyle: UIAlertControllerStyle.alert)
        
        if AccessToken.current != nil {
            result = 1
            
            let cancel = UIAlertAction.init(title: "Отдать голос!", style: UIAlertActionStyle.default) { (UIAlertAction) in
                
                self.sendRequest(member_id: self.privateListId[sender.tag])
            }
            alert.addAction(cancel)
        }
        else{
            let okAction = UIAlertAction.init(title: "Авторизироваться", style: UIAlertActionStyle.default) { (UIAlertAction) in
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier :"fb_controller") as! FBViewController
                vc.nominationId = self.nominationId
                self.present(vc, animated: true)
            }
            alert.addAction(okAction)
        }
        
        let cancel = UIAlertAction.init(title: "Отмена", style: UIAlertActionStyle.cancel) { (UIAlertAction) in }
        
        alert.addAction(cancel)
        
        // self.present(alert, animated: true, completion: nil)
        self.present(alert, animated: true, completion: {
            do{
                //self.expTable.reloadData()
            }
        })
        
    }
    
    func sendRequest(member_id: String){
        
        self.indexBun = 1
        self.expTable.isHidden = true
        
        var user_id =      ""
        var email =        ""
        var first_name =   ""
        var last_name =    ""
        
        let defaults = UserDefaults.standard
        if let fb_user_id = defaults.string(forKey: "fb_user_id"){
            user_id = fb_user_id
        }
        if let fb_email = defaults.string(forKey: "fb_email"){
            email = fb_email
        }
        if let fb_first_name = defaults.string(forKey: "fb_first_name"){
            
            if fb_first_name.isCyrillic {
                first_name = fb_first_name.slugify().uppercased()
            }
            else {
                first_name = fb_first_name
            }
            
        }
        if let fb_last_name = defaults.string(forKey: "fb_last_name"){
            if fb_last_name.isCyrillic {
                last_name = fb_last_name.slugify().uppercased()
            }
            else {
                last_name = fb_last_name
            }
        }
        
        //print(first_name.uppercased())
        //print(first_name.slugify().uppercased())
        
        
        let voteURL = "http://ksinfo1000.com/backend.php/connect/vote?user_id="+user_id+"&email="+email+"&first_name="+first_name+"&last_name="+last_name+"&member_id="+member_id+"&nomination_id="+nominationId
        //let voteURL = "http://ksinfo1000.com/backend.php/connect/vote?user_id="+user_id+"&email="+email+"&member_id="+member_id+"&nomination_id="+nominationId
        
        //print(voteURL)
        
        Alamofire.request(voteURL).responseJSON { response in
            guard response.result.error == nil else {
                print(response.result.error!)
                            return
            }
        }

        self.parseMembers()
        
        //self.reloadSectionIndexTitles()
        
    }
    
    func parseMembers()
    {
        let memberURL = "http://ksinfo1000.com/backend.php/connect/member?nomination_id="+self.nominationId+"&user_id="+user_id
        
        //print(memberURL)
        
        self.privateListId = []
        self.privateListName = []
        self.privateListBun = []
        self.privateListYoutubeId = []
        self.privateListCountVote = []
        self.privateListPresent = []
        self.privateListVote = []
        
        Alamofire.request(memberURL).responseJSON { response in
            if let value = response.result.value as? [String: AnyObject] {
                if let items = value["member"] as? [[String: AnyObject]]
                {
                    for item in items
                    {
                        if var id = item["id"] {
                            self.privateListId.append(id as! String)
                        }
                        if var name = item["name"] {
                            self.privateListName.append(name as! String)
                        }
                        if var count_vote = item["count_vote"] {
                            self.privateListCountVote.append(count_vote as! String)
                        }
                        if var my_image = item["img"] {
                            self.privateListImg.append(my_image as! String)
                        }
                        if var my_present = item["present"] {
                            self.privateListPresent.append(my_present as! String)
                        }
                        if var my_text = item["text"] {
                            self.privateListText.append(my_text.replacingOccurrences(of: "\\n", with: "\n"))
                        }
                        if var ban = item["ban"] {
                            self.privateListBun.append(ban as! String)
                        }
                        if var youtube_id = item["youtube_id"] {
                            self.privateListYoutubeId.append(youtube_id as! String)
                        }
                        if var vote = item["vote"] {
                            self.privateListVote.append(vote as! String)
                        }
                    }
                    self.expTable.reloadData()
                }
            }
        }
    }
}

extension UIImageView {
    
    func setRounded(radius:Float) {
        self.layer.cornerRadius = (self.frame.width / 2) //instead of let radius = CGRectGetWidth(self.frame) / 2
        self.layer.borderWidth = CGFloat(radius)
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.masksToBounds = true
    }
}

extension String {
    fileprivate static let allowedCharacters = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-")
    
    public func slugify() -> String {
        let cocoaString = NSMutableString(string: self) as CFMutableString
        CFStringTransform(cocoaString, nil, kCFStringTransformToLatin, false)
        CFStringTransform(cocoaString, nil, kCFStringTransformStripCombiningMarks, false)
        CFStringLowercase(cocoaString, .none)
        
        return String(cocoaString)
            .components(separatedBy: String.allowedCharacters.inverted)
            .filter { $0 != "" }
            .joined(separator: "-")
    }
    
    var isLatin: Bool {
        let upper = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let lower = "abcdefghijklmnopqrstuvwxyz"
        
        for c in self.characters.map({ String($0) }) {
            if !upper.contains(c) && !lower.contains(c) {
                return false
            }
        }
        
        return true
    }
    
    var isCyrillic: Bool {
        let upper = "АБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЬЮЯ"
        let lower = "абвгдежзийклмнопрстуфхцчшщьюя"
        
        for c in self.characters.map({ String($0) }) {
            if !upper.contains(c) && !lower.contains(c) {
                return false
            }
        }
        
        return true
    }
    
    var isBothLatinAndCyrillic: Bool {
        return self.isLatin && self.isCyrillic
    }
}
