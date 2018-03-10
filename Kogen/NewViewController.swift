//
//  NewViewController.swift
//  Kogen
//
//  Created by Kogen on 12/4/16.
//  Copyright © 2016 Kogen. All rights reserved.
//

import UIKit

class NewViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var image = ""
    var name = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let data = try? Data(contentsOf: URL(string: image)!)
        let myImage = UIImage(data:data!)
        imageView.image = myImage
        
        navigationItem.title = name
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Назад", style: .plain, target: self, action: nil)
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
 

}
