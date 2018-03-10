//
//  СastingViewController.swift
//  Kogen
//
//  Created by Kogen on 7/27/16.
//  Copyright © 2016 Kogen. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class CastingViewController: UIViewController {
    
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var videoView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.navigationController?.navigationBar.topItem?.title = "Главная"
        
        /*
        let youTube = "https://www.youtube.com/watch?v=xePLAwUXF2c"
        
        let width = 300
        let height = 200
        let frame = 10
        
        videoView.allowsInlineMediaPlayback = true
        
        videoView.loadHTMLString("<iframe width=\"\(width)\" height=\"\(height)\" src=\"https://www.youtube.com/embed/xePLAwUXF2c\" frameborder=\"\(frame)\" allowfullscreen></iframe>", baseURL: nil)
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        */
        
        
        
        
        
        let myURL : URL = URL(string: "https://www.youtube.com/embed/xePLAwUXF2c")!
        //Note: use the "embed" address instead of the "watch" address.
        let myURLRequest : URLRequest = URLRequest(url: myURL)
        self.videoView.loadRequest(myURLRequest)
       

        
        
        
        
//        let videoURL = NSURL(string: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")
//        let player = AVPlayer(URL: videoURL!)
//        let playerViewController = AVPlayerViewController()
//        playerViewController.player = player
//        self.presentViewController(playerViewController, animated: true) {
//            playerViewController.player!.play()
//        }
        
    }
    

    
}
