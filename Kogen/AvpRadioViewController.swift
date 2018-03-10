//
//  AvpRadioViewController.swift
//  Kogen
//
//  Created by Kogen on 11/22/16.
//  Copyright © 2016 Kogen. All rights reserved.
//

import UIKit
import AVFoundation
//import MediaPlayer
import Alamofire

class AvpRadioViewController: UIViewController,UITableViewDataSource, UITableViewDelegate, AvpRadioCellDelegate {

    
    @IBOutlet weak var myTableView: UITableView!
    
    var player02: AVAudioPlayer!

    var window:UIWindow?
    
    var categoryId  = ""
    
    //var radioPlayer: MPMoviePlayerController!
    var timer: Timer!
    var dem:Int = 0
    
    var myIndex: Int = 0
    
    let defaults = UserDefaults.standard
    var section = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        let sess = AVAudioSession.sharedInstance()
//        if sess.otherAudioPlaying {
//            print(44)
//            _ = try? sess.setCategory(AVAudioSessionCategoryAmbient, withOptions: []) //
//            _ = try? sess.setActive(false, withOptions: [])
//        }
        
//        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        
        getJSON()

//        if player02 != nil {
//            if player02.playing {
//                player02.stop()
//                timer.invalidate()
//                
//                getDeselected()
//
//            }
//        }
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return privateListName.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! AvpRadioViewCell
        
         cell.name?.text = privateListName[indexPath.row]
         cell.myUrl = privateListFile[indexPath.row]

        if cell.buttonDelegate == nil {
            cell.buttonDelegate = self
        }

        cell.play_options.isHidden = false
        cell.pause_options.isHidden = true
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        myIndex = indexPath.row
        
        let cell = tableView.cellForRow(at: indexPath) as! AvpRadioViewCell
        
        self.cellTapped(cell)
        
    }
    
    
    func cellTapped(_ cell: AvpRadioViewCell) {
        
        guard let indexPath = myTableView.indexPath(for: cell) else {
            return
        }
        
        let defaults = UserDefaults.standard
        let userDem = defaults.integer(forKey: "dem")
        
        if player02 != nil {
            if player02.isPlaying {
                player02.stop()
                timer.invalidate()
                
                getDeselected()
                
                if userDem == indexPath.row
                {
                    return
                }
            }
        }
        
        
        myTableView.selectRow(at: IndexPath(row: indexPath.row, section: 0), animated: true, scrollPosition: .none)
        
        getDeselected()
        
        let audio = cell.myUrl

        cell.play_options.isHidden = true
        cell.pause_options.isHidden = false
        
        
        self.play_music(privateListFile[indexPath.row])
        dem = indexPath.row
        

        defaults.set(dem, forKey: "dem")

        //self.play_music(audio)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(AvpRadioViewController.update_time), userInfo: nil, repeats: true)
        
    }

    func update_time()
    {
        
        //Важно!
//        let defaults = NSUserDefaults.standardUserDefaults()
//        let indexPathMain = defaults.integerForKey("indexPathMain")
//        let indexTab = defaults.integerForKey("indexTab")
//        
//        
//        if indexPathMain != 2 || indexTab < 1
//        {
//            player02.stop()
//            timer.invalidate()
//            
//            getDeselected()
//        }

        
        //MediaViewController().TabIndex.FirstChildTab.rawValue
        
        
        //MasterViewController()            myTableView.selectRowAtIndexPath(NSIndexPath(forRow: dem, inSection: 0), animated: true, scrollPosition: .None)
        
            //myTableView.selectRowAtIndexPath(NSIndexPath(forRow: dem, inSection: 0), animated: true, scrollPosition: .None)
        
        
        //let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        //print(appDelegate.demas)
        
//        if let wd = self.window {
//            var vc = wd.rootViewController
//            if(vc is UINavigationController){
//                vc = (vc as UINavigationController).visibleViewController
//            }
//            
//            if(vc is YourViewController){
//                //your code
//            }
//        }        
//        if self.window!.rootViewController is AvpRadioViewController {
//            
//            print(56)
//        }

//        if self is AvpRadioViewController {
//            print(34)
//        }
        
        let cur = player02.currentTime

        if player02.duration - player02.currentTime < 1
        {
            if (dem == privateListFile.count - 1) { dem = -1 }
            
            dem = dem + 1
            
            let defaults = UserDefaults.standard
            defaults.set(dem, forKey: "dem")
            
            play_music(privateListFile[dem])

            
            myTableView.selectRow(at: IndexPath(row: dem, section: 0), animated: true, scrollPosition: .none)
            
            let makl = dem + 1

            getDeselectedNext(dem)
            
//            dem = dem + 1
//            let dur = player02.duration

//            play_options.hidden = true
//            pause_options.hidden = false
            player02.play()
        }

    }
    
    func getDeselected()
    {
        for obj in myTableView.visibleCells {
            if let cell = obj as? AvpRadioViewCell {
                cell.play_options.isHidden = false
                cell.pause_options.isHidden = true
            }
        }
    }
    
    func getDeselectedNext(_ row: Int)
    {
        for obj in myTableView.visibleCells {
            if let cell = obj as? AvpRadioViewCell {
                
                let indexPath = myTableView.indexPath(for: cell)
                
                if row==indexPath?.row
                {
                    cell.play_options.isHidden = true
                    cell.pause_options.isHidden = false
                }
                else
                {
                    cell.play_options.isHidden = false
                    cell.pause_options.isHidden = true
                }

            }
        }
    }
    
    func play_music(_ row: String) {
        
        
//        var url = NSURL(string: row)
//        var data = NSData(contentsOfURL: url!)
//        
//        do
//        {
//            player02 = try AVAudioPlayer(data: data!)
//        }
//        catch
//        {
//        }
//        player02.play()
        
        
        let url = URL(string: row)
        let data = try? Data(contentsOf: url!)
        
        do {
 
                try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
                try AVAudioSession.sharedInstance().setActive(true)
                player02 = try AVAudioPlayer(data: data!)
//                player02.numberOfLoops = -1
//                player02.prepareToPlay()
                player02.play()
                
            
        } catch {
            print(error)
        }
        
        
        
        
        
//        var u:NSURL = NSURL(string: row)! // Force unwrapping so you better make sure the array exists.
//        
//        let playeritem = AVPlayerItem(URL: u)
//        let myplayer = AVPlayer(playerItem: playeritem)
//        let playerlayer = AVPlayerLayer(player: myplayer)
//        playerlayer.frame = CGRectMake(0, 0, 10, 15)
//        self.view.layer.addSublayer(playerlayer)
//        
//        myplayer.play()
        
        
//                var url = NSURL(string: row)
//                var data = NSData(contentsOfURL: url!)
//        
//                do
//                {
//                    player02 = try AVAudioPlayer(data: data!)
//                }
//                catch
//                {
//                }
//                player02.play()
        
        
//        if let path = Bundle.main.path(forResource: "TestSound", ofType: "wav") {
//            let filePath = NSURL(fileURLWithPath:path)
//            songPlayer = try! AVAudioPlayer.init(contentsOf: filePath as URL)
//            songPlayer?.numberOfLoops = -1 //logic for infinite loop
//            songPlayer?.prepareToPlay()
//            songPlayer?.play()
//        }
//        
//        let audioSession = AVAudioSession.sharedInstance()
//        try!audioSession.setCategory(AVAudioSessionCategoryPlayback, with: AVAudioSessionCategoryOptions.duckOthers) //Causes audio from other sessions to be ducked (reduced in volume) while audio from this session plays
//        
//
    }
    
    var baseURL="http://ksinfo1000.com/backend.php/connect_ks/audio"
    var privateListName         = [String]()
    var privateListFile         = [String]()
    
    
    func getJSON()
    {
        section = defaults.integer(forKey: "section")
        let url = URL(string: baseURL + "?category_id="+categoryId+"&section_id=" + String(section))

        //let url = URL(string: baseURL + "?category_id="+String(categoryId))
        
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
//        let url = URL(string: baseURL + "?category_id="+String(categoryId))
//
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
    
    
//    func showAlertForRow2(_ row: String) {
//        
//        let url: NSURL = NSURL(string: row)!
//        
//        radioPlayer = MPMoviePlayerController(contentURL: url)
//        
//        radioPlayer.view.frame = CGRect(x: 20, y: 20, width: 10, height: 10)
//        radioPlayer.view.sizeToFit()
//        //  radioPlayer.movieSourceType = MPMovieSourceType.streaming
//        radioPlayer.fullscreen = true
//        radioPlayer.shouldAutoplay = true
//        radioPlayer.prepareToPlay()
//        radioPlayer.controlStyle = MPMovieControlStyle.Embedded
//        
//        //    enum MPMoviePlaybackState : Int {
//        //        case Stopped
//        //        case Playing
//        //        case Paused
//        //        case Interrupted
//        //        case SeekingForward
//        //        case SeekingBackward
//        //    }
//        
//        //        let state: MPMoviePlaybackState = radioPlayer.playbackState
//        //        switch state
//        //        {
//        //        case MPMoviePlaybackState.Stopped:
//        //            print("stopped")
//        //            break
//        //        case MPMoviePlaybackState.Interrupted:
//        //            print("interrupted")
//        //            break
//        //        case MPMoviePlaybackState.SeekingForward:
//        //            print("forward")
//        //            break
//        //        case MPMoviePlaybackState.SeekingBackward:
//        //            print("backward")
//        //            break
//        //        case MPMoviePlaybackState.Paused:
//        //            print("paused")
//        //            break
//        //        case MPMoviePlaybackState.Playing:
//        //            print("playing")
//        //            break
//        //        }
//    }
    
}
