//
//  ViewController.swift
//  AV Player
//
//  Created by Merlyn on 10/2/15.
//  Copyright © 2015 The App Lady. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import Alamofire

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!

    var selectedUrl = String()
    var selectedTitle = String()


    var baseURL="http://ksinfo1000.com/backend.php/connect/video_file"
    
    var privateListName         = [String]()
    var privateListFile         = [String]()
    var privateListImg      = [String]()
    
    func getJSON()
    {
        let url = URL(string: baseURL)
        
        self.privateListName = []
        self.privateListImg = []
        self.privateListFile = []
        
        Alamofire.request(url!).responseJSON { response in
            if let value = response.result.value as? [String: AnyObject] {
                if let posts = value["video_file"] as? [[String: AnyObject]]
                {
                    for contacts in posts
                    {
                        
                        if var name = contacts["name"] {
                            self.privateListName.append(name as! String)
                        }
                        if var img = contacts["img"] {
                            self.privateListImg.append(img as! String)
                        }
                        if var file = contacts["file"] {
                            self.privateListFile.append(file as! String)
                        }
                        
                        self.tableView.reloadData()
                        
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
//        
//        let task = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
//            if error == nil {
//                let swiftyJSON = JSON(data: data!)
//                let privateListArray = swiftyJSON["video_file"].arrayValue
//                DispatchQueue.main.async(execute: {
//                    for contacts in privateListArray
//                    {
//                        let name        = contacts["name"].stringValue
//                        let file        = contacts["file"].stringValue
//                        let img         = contacts["img"].stringValue
//                        
//                        self.privateListName.append(name)
//                        self.privateListFile.append(file)
//                        self.privateListImg.append(img)
//
//                        
//                        DispatchQueue.main.async(execute: {
//                            self.tableView.reloadData()
//                        })
//                        
//                    }
//                    
//                })
//                
//            } else {
//                print("Error url")
//            }
//            
//        }) 
//        task.resume()
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getJSON()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        return privateListName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "videoCell", for: indexPath) as! VideoFileTableViewCell

        if privateListImg[indexPath.row] > "" {
            
            let data = try? Data(contentsOf: URL(string: privateListImg[indexPath.row])!)
            let myImage = UIImage(data:data!)
            
            cell.thumbnailImageView!.image = myImage
            
        }
        else{
            cell.thumbnailImageView!.image = UIImage()
        }
        
        
         cell.nameLabel?.text = privateListName[indexPath.row]
        
        
        
        return cell
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showVideoPlayer" {
            
            
                        if let indexPath = self.tableView.indexPathForSelectedRow {

                            let video = privateListFile[(indexPath as IndexPath).row]
            
                            let destination = segue.destination as! AVPlayerViewController
                            let url = URL(string: video)!
            
                            destination.player = AVPlayer(url: url)
                            destination.player?.play()
                            
                            
                        }
        }

    }
    
}
