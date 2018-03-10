//
//  ThirdMediaViewController.swift
//  Kogen
//
//  Created by Kogen on 10/13/16.
//  Copyright © 2016 Kogen. All rights reserved.
//

import UIKit
import Alamofire

//class ThirdMediaViewController: UIViewController,YTPlayerViewDelegate {
class ThirdMediaViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, YTPlayerViewDelegate {
//    @IBOutlet weak var player: YTPlayerView!

    @IBOutlet weak var myTableView: UITableView!
    
    var baseURL = "http://ksinfo1000.com/backend.php/connect/video"
    var privateList             = [String]()
    var privateListYoutubeId    = [String]()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //myTableView.backgroundColor = UIColor.blueColor()
         getJSON()
        
    }

//     func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell,
//                            forRowAtIndexPath indexPath: NSIndexPath) {
//
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        var returnValue = 0
        
        returnValue = privateList.count
        return returnValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! ThirdTableViewCell

        myCell.player.load(withVideoId: privateListYoutubeId[indexPath.row])


        
        return myCell
    }

//    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        
//        print(indexPath.row)
//
//        
//    }
    
    func getJSON()
    {
        let url = URL(string: baseURL)
        
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
                        
                        self.myTableView.reloadData()
                        
                    }
                }
            }
        }
    }


//    func getJSON()
//    {
//        self.privateList = []
//        
//        let url = URL(string: baseURL)
//        let request = URLRequest(url: url!)
//        let session = URLSession(configuration: URLSessionConfiguration.default)
//        let task = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
//            if error == nil {
//                let swiftyJSON = JSON(data: data!)
//                //let theTitle = swiftyJSON["concerts"][0].stringValue
//                let privateListArray = swiftyJSON["video"].arrayValue
//                
//                DispatchQueue.main.async(execute: {
//                    for contacts in privateListArray
//                    {
//                        let name        = contacts["name"].stringValue
//                        let youtube_id  = contacts["youtube_id"].stringValue
//                        
//                        self.privateList.append(name)
//                        self.privateListYoutubeId.append(youtube_id)
//                        
//                        DispatchQueue.main.async(execute: {
//                            self.myTableView.reloadData()
//                        })
//                    }
//                })
//                
//            } else {
//                print("Error url")
//            }
//        }) 
//        task.resume()
//    }
    
}
