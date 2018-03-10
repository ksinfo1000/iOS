//
//  SelfSevelopmentUIViewController.swift
//  Kogen
//
//  Created by Kogen on 7/27/16.
//  Copyright © 2016 Kogen. All rights reserved.
//

import UIKit

class SelfSevelopmentViewController: UIViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil {
            
            revealViewController().rearViewRevealWidth = 150
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
