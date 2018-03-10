//
//  RadioViewController.swift
//  Kogen
//
//  Created by Kogen on 7/27/16.
//  Copyright © 2016 Kogen. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

class RadioViewController: UIViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    var radioPlayer: MPMoviePlayerController!
    
    let url = "http://online-hitfm.tavrmedia.ua/HitFM"
    
    var avPlayer: AVPlayer!
    
    @IBOutlet weak var playButton: UIButton!
    @IBAction func playButtoAction(_ sender: AnyObject) {
        self.showAlertForRow(url)
    }
    
    @IBOutlet weak var pauseButton: UIButton!
    @IBAction func pauseButtonAction(_ sender: AnyObject) {
        appDelegate.radioPlayerMain.pause()
        playButton.isHidden = false
        pauseButton.isHidden = true
        let defaults = UserDefaults.standard
        defaults.set(0, forKey: "radio_stream_play")
    }
    
    
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Радио"
        
        UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
        
        if self.revealViewController() != nil {
            revealViewController().rearViewRevealWidth = 300
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        
        let defaults = UserDefaults.standard
        let radio_stream_play = defaults.integer(forKey: "radio_stream_play")
        
        if(radio_stream_play == 1)
        {
            playButton.isHidden = true
            pauseButton.isHidden = false
        }
        else
        {
            playButton.isHidden = false
            pauseButton.isHidden = true
        }



//        let appDelegate2 = UIApplication.sharedApplication().delegate as! AppDelegate
//
//        
//        if let playback1st = appDelegate2.radioPlayerMain.playbackState
//        {
//            print(playback1st)
//        }
        //print(appDelegate2.radioPlayerMain.playbackState)
        
//        if appDelegate2.radioPlayerMain.playbackState == MPMoviePlaybackState.Playing
//        {
//            print("Playing")
//            //appDelegate.radioPlayerMain.stop()
//        }
//        else {
//            print("Stopped")
//        }
        
        
//        self.showAlertForRow(url)

    }
    
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    override var preferredInterfaceOrientationForPresentation : UIInterfaceOrientation {
        return UIInterfaceOrientation.portrait
    }
    
    func showAlertForRow(_ row: String) {
        
        let url: URL = URL(string: row)!

        appDelegate.radioPlayerMain = MPMoviePlayerController(contentURL: url)
        
        appDelegate.radioPlayerMain.view.frame = CGRect(x: 20, y: 20, width: 10, height: 10)
        appDelegate.radioPlayerMain.view.sizeToFit()
        //  radioPlayer.movieSourceType = MPMovieSourceType.streaming
        appDelegate.radioPlayerMain.isFullscreen = true
        appDelegate.radioPlayerMain.shouldAutoplay = true
        appDelegate.radioPlayerMain.prepareToPlay()
        appDelegate.radioPlayerMain.controlStyle = MPMovieControlStyle.embedded
        
        playButton.isHidden = true
        pauseButton.isHidden = false
        
        let defaults = UserDefaults.standard
        defaults.set(1, forKey: "radio_stream_play")
        
        //cell.pause_options.hidden = false
        
//                            enum MPMoviePlaybackState : Int {
//                                case Stopped
//                                case Playing
//                                case Paused
//                                case Interrupted
//                                case SeekingForward
//                                case SeekingBackward
//                            }
        
//        radioPlayer = MPMoviePlayerController(contentURL: url)
//        
//        radioPlayer.view.frame = CGRect(x: 20, y: 20, width: 10, height: 10)
//        radioPlayer.view.sizeToFit()
//        //  radioPlayer.movieSourceType = MPMovieSourceType.streaming
//        radioPlayer.fullscreen = true
//        radioPlayer.shouldAutoplay = true
//        radioPlayer.prepareToPlay()
//        radioPlayer.controlStyle = MPMovieControlStyle.Embedded
        
        //appDelegate.radioPlayerMain.stop()
        
        //radioPlayer.playbackState
        
        //print(radioPlayer.playbackState)
        
//        let state: MPMoviePlaybackState = radioPlayer.playbackState
        //print(state)
//                        let state: MPMoviePlaybackState = radioPlayer.playbackState
//                        switch state
//                         {
//                        case MPMoviePlaybackState.Stopped:
//                            print("stopped")
//                            break
//                        case MPMoviePlaybackState.Interrupted:
//                            print("interrupted")
//                            break
//                        case MPMoviePlaybackState.SeekingForward:
//                            print("forward")
//                            break
//                        case MPMoviePlaybackState.SeekingBackward:
//                            print("backward")
//                            break
//                        case MPMoviePlaybackState.Paused:
//                            print("paused")
//                            break
//                        case MPMoviePlaybackState.Playing:
//                            print("playing")
//                            break
//                        }
        
        
        

        
//                    enum MPMoviePlaybackState : Int {
//                        case Stopped
//                        case Playing
//                        case Paused
//                        case Interrupted
//                        case SeekingForward
//                        case SeekingBackward
//                    }
        

        
//        if(radioPlayer.playbackState)
//        {
//            // is Playing
//        }
        
//                        let state: MPMoviePlaybackState = appDelegate.radioPlayerMain.playbackState
//                        switch state
//                        {
//                        case MPMoviePlaybackState.Stopped:
//                            print("stopped")
//                            break
//                        case MPMoviePlaybackState.Interrupted:
//                            print("interrupted")
//                            break
//                        case MPMoviePlaybackState.SeekingForward:
//                            print("forward")
//                            break
//                        case MPMoviePlaybackState.SeekingBackward:
//                            print("backward")
//                            break
//                        case MPMoviePlaybackState.Paused:
//                            print("paused")
//                            break
//                        case MPMoviePlaybackState.Playing:
//                            print("playing")
//                            break
//                        }
    }
    
}
