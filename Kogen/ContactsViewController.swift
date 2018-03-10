//
//  ContactsViewController.swift
//  Kogen
//
//  Created by Kogen on 7/27/16.
//  Copyright © 2016 Kogen. All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController, YTPlayerViewDelegate {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var player: YTPlayerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        player.load(withVideoId: "5i8nRJ24jhg")
        
        if self.revealViewController() != nil {
            
            revealViewController().rearViewRevealWidth = 300
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
