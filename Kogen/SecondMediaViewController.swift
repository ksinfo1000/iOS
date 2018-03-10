//
//  SecondMediaViewController.swift
//  Kogen
//
//  Created by Kogen on 10/13/16.
//  Copyright © 2016 Kogen. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer
import Alamofire

class SecondMediaViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ButtonCellDelegate {
    

    @IBOutlet weak var myTableView: UITableView!

    
    @IBOutlet weak var tableView: UITableView!
    var privateListName         = [String]()
    var privateListFile         = [String]()
    

    
    var radioPlayer: MPMoviePlayerController!

    var baseURL="http://ksinfo1000.com/backend.php/connect/audio"
    
    
    func getJSON()
    {
        let url = URL(string: baseURL)
        
        Alamofire.request(url!).responseJSON { response in
            if let value = response.result.value as? [String: AnyObject] {
                if let posts = value["audio"] as? [[String: AnyObject]]
                {
                    for contacts in posts
                    {
                        if var name = contacts["name"] {
                            self.privateListName.append(name as! String)
                        }
                        if var file = contacts["file"] {
                            self.privateListFile.append(file as! String)
                        }
                        
                        self.myTableView.reloadData()
                        
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
//                let privateListArray = swiftyJSON["audio"].arrayValue
//                DispatchQueue.main.async(execute: {
//                    for contacts in privateListArray
//                    {
//                        let name        = contacts["name"].stringValue
//                        let file        = contacts["file"].stringValue
//                        
//                        self.privateListName.append(name)
//                        self.privateListFile.append(file)
//                        
//                        DispatchQueue.main.async(execute: {
//                            self.myTableView.reloadData()
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        return privateListName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "audioCell", for: indexPath) as! ButtonCell
         cell.nameLabel?.text = privateListName[indexPath.row]
         cell.myUrl = privateListFile[indexPath.row]
        
        if cell.buttonDelegate == nil {
            cell.buttonDelegate = self
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(indexPath.row)
        let audio = privateListFile[(indexPath as IndexPath).row]
        
        
        let url:URL = URL(string: audio)!

        let cell = tableView.dequeueReusableCell(withIdentifier: "audioCell", for: indexPath) as! ButtonCell
        cell.nameLabel?.text = privateListName[indexPath.row]
        cell.audioUrl = url


    }
    
    func cellTapped(_ cell: ButtonCell) {
        
        let audio = cell.myUrl
        
        self.showAlertForRow(audio)
    }
    
    // MARK: - Extracted method
    
    func showAlertForRow(_ row: String) {
        
        let url: URL = URL(string: row)!
        
        radioPlayer = MPMoviePlayerController(contentURL: url)
        
        radioPlayer.view.frame = CGRect(x: 20, y: 20, width: 10, height: 10)
        radioPlayer.view.sizeToFit()
        //  radioPlayer.movieSourceType = MPMovieSourceType.streaming
        radioPlayer.isFullscreen = true
        radioPlayer.shouldAutoplay = true
        radioPlayer.prepareToPlay()
        radioPlayer.controlStyle = MPMovieControlStyle.embedded
        
    }
    
}
