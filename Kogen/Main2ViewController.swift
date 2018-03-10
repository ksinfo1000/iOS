//
//  Main2ViewController.swift
//  KozhenSpromozhen
//
//  Created by Kogen on 4/6/17.
//  Copyright © 2017 KozhenSpromozhen. All rights reserved.
//

import UIKit

class Main2ViewController: UIViewController, CAAnimationDelegate {
    var timer: Timer!
    @IBOutlet weak var slidingTextLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
          timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(Main2ViewController.moveToNextPage), userInfo: nil, repeats: true)
    }

    func moveToNextPage (){
        self.slidingTextLabel.slideInFromLeft()
        self.slidingTextLabel.text = "Sliding Text 2!"
    }
    
    @IBAction func slideTextButtonTapped(_ sender: AnyObject) {
        self.slidingTextLabel.slideInFromLeft()
        //		self.slidingTextLabel.slideInFromLeft(3.0, completionDelegate: self) // Use this line to specify a duration or completionDelegate
        self.slidingTextLabel.text = "Sliding Text!"
    }
}
