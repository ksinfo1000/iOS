//
//  LiveYesViewController.swift
//  Kogen
//
//  Created by Kogen on 11/12/16.
//  Copyright © 2016 Kogen. All rights reserved.
//

import UIKit
import Alamofire

class LiveYesViewController: UIViewController {

    @IBOutlet weak var player: YTPlayerView!
    var baseURL = "http://ksinfo1000.com/backend.php/connect/settings"
    
    @IBOutlet weak var nameLive: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getJSON()
    }

    func getJSON()
    {
        Alamofire.request("http://ksinfo1000.com/backend.php/connect/settings").responseJSON { response in
            if let value = response.result.value as? [String: AnyObject] {
                if let settings = value["settings"] as? [String: AnyObject]
                {
                    if let name_live = settings["youtube_name"]
                    {
                        self.nameLive.text = name_live as! String
                    }
                    if let youtube_id = settings["youtube_id"]
                    {
                        self.player.load(withVideoId: youtube_id as! String)
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
//                let youtube_id = swiftyJSON["settings"]["youtube_id"].string!
//                let name_live = swiftyJSON["settings"]["youtube_name"].string!
//                DispatchQueue.main.async(execute: {
//                    self.player.load(withVideoId: youtube_id)
//                    self.nameLive.text = name_live
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
