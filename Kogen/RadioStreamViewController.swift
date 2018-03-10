//
//  RadioStreamViewController.swift
//  Kogen
//
//  Created by Kogen on 11/16/16.
//  Copyright © 2016 Kogen. All rights reserved.
//

import UIKit
import AVFoundation
import Alamofire

class RadioStreamViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var player: AVPlayer!
    var timer: Timer!
    var player02: AVAudioPlayer!
    
    
    
    
    var baseURL="http://ksinfo1000.com/backend.php/connect/audio"
    var privateListName         = [String]()
    var privateListFile         = [String]()
    
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
                        
                        self.tbl_music.reloadData()
                        
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
//
//            if error == nil {
//                
//                let swiftyJSON = JSON(data: data!)
//                let privateListArray = swiftyJSON["audio"].arrayValue
//                
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
//                            self.tbl_music.reloadData()
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
//                    print(3244)
//        task.resume()
//    }
    
    
    
    
    
    @IBOutlet weak var lbl_tenbaihat: UILabel!
    
    
    @IBOutlet weak var volume: UIButton!
    @IBAction func volume_click(_ sender: AnyObject) {
        mute.isHidden = false
        volume.isHidden = true
        player02.volume = 0
    }

    
    @IBOutlet weak var mute: UIButton!
    @IBAction func mute_action(_ sender: AnyObject) {
        mute.isHidden = true
        volume.isHidden = false
        player02.volume = slider_volume.value
    }
    

    @IBOutlet weak var slider_time: UISlider!
    @IBAction func slider_action(_ sender: AnyObject) {
        
        player02.currentTime = TimeInterval(slider_time.value)
        
    }
    
    
    @IBOutlet weak var slider_volume: UISlider!
    @IBAction func volume_action(_ sender: AnyObject) {
        player02.volume = slider_volume.value
    }
    
    
    @IBAction func click_play(_ sender: AnyObject) {
        //player.play()
        player02.play()
        play_options.isHidden = true
        pause_options.isHidden = false
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(RadioStreamViewController.update_time), userInfo: nil, repeats: true)
    }

    
    @IBAction func click_pause(_ sender: AnyObject) {
//        player.pause()
        player02.pause()
        play_options.isHidden = false
        pause_options.isHidden = true
    }
    var dem:Int = 0
    func update_time()
    {
        //let cur = player.currentTime().seconds
        let cur = player02.currentTime
        slider_time.value = Float(cur)
        
        if cur == 0.0
        {
            play_options.isHidden = false
            pause_options.isHidden = true
        }
        
        if player02.duration - player02.currentTime < 2
        {
            if (dem == privateListFile.count - 1) { dem = -1 }
            play_music(privateListFile[dem + 1])
            lbl_tenbaihat.text = privateListName[dem + 1]
            
            tbl_music.selectRow(at: IndexPath(row: dem + 1, section: 0), animated: true, scrollPosition: .none)
            
            dem = dem + 1
            let dur = player02.duration
            slider_time.maximumValue = Float(dur)
            slider_time.minimumValue = 0
            slider_time.value = 0
            play_options.isHidden = true
            pause_options.isHidden = false
            player02.play()
            
        }

    }
    
    @IBOutlet weak var play_options: UIButton!

    @IBOutlet weak var pause_options: UIButton!
    
//    @IBAction func click_stop(sender: AnyObject) {
//        player.pause()
//        player = nil
//        play_music()
//    }

    
    
    
    var tenbaihat:[String] = ["Song 1", "Song 2", "SOng 3"]
    var linkbaihat:[String] = [
        "http://ksinfo1000.com/uploads/audio/hanna_-_bez_tebja_ja_ne_mogu_radio_edit_-zf-fm.mp3",
        "http://ksinfo1000.com/uploads/audio/hanna_-_bez_tebja_ja_ne_mogu_radio_edit_-zf-fm.mp3",
        "http://ksinfo1000.com/uploads/audio/hanna_-_bez_tebja_ja_ne_mogu_radio_edit_-zf-fm.mp3"]
    
    @IBOutlet weak var tbl_music: UITableView!
    
//    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        <#code#>
//    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return privateListName.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = privateListName[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        lbl_tenbaihat.text = privateListName[indexPath.row]
        play_music(privateListFile[indexPath.row])
        
        let dur = player02.duration
        slider_time.maximumValue = Float(dur)
        slider_time.minimumValue = 0
        slider_time.value = 0
        play_options.isHidden = false
        pause_options.isHidden = true
        dem = indexPath.row
        
    }


    func play_music(_ linkbaihat_s : String)
    {
        let url = URL(string: linkbaihat_s)
        let data = try? Data(contentsOf: url!)
        
        do
        {
            player02 = try AVAudioPlayer(data: data!)
        }
        catch
        {
        }
        
        //player = AVPlayer(URL: url!)

    }
    


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // No need for semicolon

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        

        
        Alamofire.request("http://ksinfo1000.com/backend.php/connect/audio").responseJSON { response in
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
                        
                        //self.myTableView.reloadData()
                        
                    }
                }
                
                self.play_music(self.privateListFile[0])
                self.lbl_tenbaihat.text = self.privateListName[0]
                
                self.play_options.isHidden = false
                self.pause_options.isHidden = true
                
                //        let dur = player.currentItem?.asset.duration.seconds
                //        let cur = player.currentTime().seconds
                
                let dur = self.player02.duration
                self.slider_time.maximumValue = Float(dur)
                self.slider_time.minimumValue = 0
                self.slider_time.value = 0
                
                self.slider_volume.maximumValue = 1
                self.slider_volume.minimumValue = 0
                self.slider_volume.value = 0.5
                
                self.mute.isHidden = true
                self.volume.isHidden = false
                
                self.tbl_music.delegate = self
                self.tbl_music.dataSource = self
                
                self.tbl_music.selectRow(at: IndexPath(row: self.dem, section: 0), animated: true, scrollPosition: .none)
                
                let httpResponse = response as! HTTPURLResponse
                let statusCode = httpResponse.statusCode
                
                if (statusCode == 200) {
                    print("Everyone is fine, file downloaded successfully.")
                }
                
                
            }
        }

        
//        let requestURL: URL = URL(string: "http://ksinfo1000.com/backend.php/connect/audio")!
//        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(url: requestURL)
//        let session = URLSession.shared
//        
//        let task = session.dataTask(with: urlRequest, completionHandler: {
//            (data, response, error) -> Void in
//            
//            
//            
//            if error == nil {
//                
//                let swiftyJSON = JSON(data: data!)
//                let privateListArray = swiftyJSON["audio"].arrayValue
//                print(privateListArray.count)
//                
//                DispatchQueue.main.async(execute: {
//                    for contacts in privateListArray
//                    {
//                        let name        = contacts["name"].stringValue
//                        let file        = contacts["file"].stringValue
//
//                        self.privateListName.append(name)
//                        self.privateListFile.append(file)
//                        
////                        dispatch_async(dispatch_get_main_queue(),{
////                            self.tbl_music.reloadData()
////                        })
//                        
//                    }
//                    
//                    
//                    
//                    
//                            self.play_music(self.privateListFile[0])
//                            self.lbl_tenbaihat.text = self.privateListName[0]
//                    
//                            self.play_options.isHidden = false
//                            self.pause_options.isHidden = true
//                    
//                            //        let dur = player.currentItem?.asset.duration.seconds
//                            //        let cur = player.currentTime().seconds
//                    
//                            let dur = self.player02.duration
//                            self.slider_time.maximumValue = Float(dur)
//                            self.slider_time.minimumValue = 0
//                            self.slider_time.value = 0
//                    
//                            self.slider_volume.maximumValue = 1
//                            self.slider_volume.minimumValue = 0
//                            self.slider_volume.value = 0.5
//                            
//                            self.mute.isHidden = true
//                            self.volume.isHidden = false
//                            
//                            self.tbl_music.delegate = self
//                            self.tbl_music.dataSource = self
//                            
//                            self.tbl_music.selectRow(at: IndexPath(row: self.dem, section: 0), animated: true, scrollPosition: .none)
//                            //        print(dur)
//                    
//                    
//                    
//                })
//                
//            } else {
//                print("Error url")
//            }
//            
//            
//            
//            let httpResponse = response as! HTTPURLResponse
//            let statusCode = httpResponse.statusCode
//            
//            if (statusCode == 200) {
//                print("Everyone is fine, file downloaded successfully.")
//            }
//            
//            
//            
//        }) 
//        
//        task.resume()
        
        

        
//        print(self.privateListFile[0])

        

 
//        play_music(privateListFile[0])
//        lbl_tenbaihat.text = privateListName[0]
//        
//        play_options.hidden = false
//        pause_options.hidden = true
//        
//        //        let dur = player.currentItem?.asset.duration.seconds
//        //        let cur = player.currentTime().seconds
//        
//        let dur = player02.duration
//        slider_time.maximumValue = Float(dur)
//        slider_time.minimumValue = 0
//        slider_time.value = 0
//        
//        slider_volume.maximumValue = 1
//        slider_volume.minimumValue = 0
//        slider_volume.value = 0.5
//        
//        mute.hidden = true
//        volume.hidden = false
//        
//        tbl_music.delegate = self
//        tbl_music.dataSource = self
//        
//        tbl_music.selectRowAtIndexPath(NSIndexPath(forRow: dem, inSection: 0), animated: true, scrollPosition: .None)
//        //        print(dur)
 
    }
    
    
}
