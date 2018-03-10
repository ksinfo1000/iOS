//
//  FirstViewController.swift
//  Kogen
//
//  Created by Kogen on 10/1/16.
//  Copyright © 2016 Kogen. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {


    @IBAction func next2(sender: AnyObject) {
        let vc = AfficheViewController(nibName: "AfficheViewController", bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func next(sender: AnyObject) {
        let vc = AfficheViewController(nibName: "AfficheViewController", bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
