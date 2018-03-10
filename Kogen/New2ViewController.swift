//
//  New2ViewController.swift
//  KozhenSpromozhen
//
//  Created by Kogen on 2/8/17.
//  Copyright © 2017 KozhenSpromozhen. All rights reserved.
//

import UIKit
import Alamofire

class New2ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, YTPlayerViewDelegate {

    var baseURL = "http://ksinfo1000.com/backend.php/connect_ks/video"
    var privateList             = [String]()
    var privateListYoutubeId    = [String]()
    
    var categoryId  = ""
    
    @IBOutlet weak var tablwView: UITableView!
    
    let defaults = UserDefaults.standard
    var section = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         getJSON()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        var returnValue = 0
        returnValue = privateList.count
        return returnValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let myCell = tablwView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! New2TableViewCell
        
        myCell.player.load(withVideoId: privateListYoutubeId[indexPath.row])
        
        return myCell
    }
    
    func getJSON()
    {
        section = defaults.integer(forKey: "section")
        let url = URL(string: baseURL + "?category_id="+categoryId+"&section_id=" + String(section))
        
        self.privateList = []
        self.privateListYoutubeId = []
        
        
        Alamofire.request(url!).responseJSON { response in
            if let value = response.result.value as? [String: AnyObject] {
                if let posts = value["video"] as? [[String: AnyObject]]
                {
                    for contacts in posts
                    {
                        if var name = contacts["name"] {
                            self.privateList.append(name as! String)
                        }
                        if var youtube_id = contacts["youtube_id"] {
                            self.privateListYoutubeId.append(youtube_id as! String)
                        }
                    }
                    self.tablwView.reloadData()
                }
            }
        }
    }

}
