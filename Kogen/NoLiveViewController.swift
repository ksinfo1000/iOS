//
//  NoLiveViewController.swift
//  Kogen
//
//  Created by Kogen on 11/12/16.
//  Copyright © 2016 Kogen. All rights reserved.
//

import UIKit
import Alamofire

class NoLiveViewController: UIViewController {

    @IBOutlet weak var translationText_1: UILabel!
    @IBOutlet weak var translationText: UILabel!
    var baseURL = "http://ksinfo1000.com/backend.php/connect/settings"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getJSON()
    }
    
    
    func getJSON()
    {
        var youtube_id =    ""
        var name_live =     ""
        var youtube_date =  ""
        var youtube_time =  ""
        
        Alamofire.request("http://ksinfo1000.com/backend.php/connect/settings").responseJSON { response in
            if let value = response.result.value as? [String: AnyObject] {
                if let settings = value["settings"] as? [String: AnyObject]
                {
                    if (settings["youtube_id"] != nil)
                    {
                        youtube_id = settings["youtube_id"] as! String
                    }
                    if (settings["youtube_name"] != nil)
                    {
                        name_live = settings["youtube_name"] as! String
                    }
                    if (settings["youtube_date_format"] != nil)
                    {
                        youtube_date = settings["youtube_date_format"] as! String
                    }
                    if (settings["youtube_time"] != nil)
                    {
                        youtube_time = settings["youtube_time"] as! String
                    }
                    
                    if name_live.characters.count > 0 {
                        self.translationText_1.text = "Следующая трансляция состоится \n" + youtube_date + ( youtube_time.characters.count > 0 ? " в " + youtube_time: "")
                        self.translationText.text = name_live
                    }
                    else{
                        self.translationText_1.text = ""
                        self.translationText.text = ""
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
//                
//                
//                let youtube_id = swiftyJSON["settings"]["youtube_id"].string!
//                let name_live = swiftyJSON["settings"]["youtube_name"].string!
//                let youtube_date = swiftyJSON["settings"]["youtube_date_format"].string!
//                let youtube_time = swiftyJSON["settings"]["youtube_time"].string!
//                
//                DispatchQueue.main.async(execute: {
//                        if name_live.characters.count > 0 {
//                            self.translationText_1.text = "Следующая трансляция состоится \n" + youtube_date + ( youtube_time.characters.count > 0 ? " в " + youtube_time: "")
//                            self.translationText.text = name_live
//                        }
//                        else{
//                            self.translationText_1.text = ""
//                            self.translationText.text = ""
//                        }
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
