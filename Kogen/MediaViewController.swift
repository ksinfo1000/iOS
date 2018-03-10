//
//  AboutViewController.swift
//  Kogen
//
//  Created by Kogen on 8/11/16.
//  Copyright © 2016 Kogen. All rights reserved.
//

import UIKit

class MediaViewController: UIViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!

    enum TabIndex : Int {
        case firstChildTab = 0
        case secondChildTab = 1
        case thirdChildTab = 2
    }

    var currentViewController: UIViewController?
    lazy var firstChildTabVC: UIViewController? = {
        //let firstChildTabVC = self.storyboard?.instantiateViewControllerWithIdentifier("ThirdMediaViewControllerId")
        
        let firstChildTabVC = self.storyboard?.instantiateViewController(withIdentifier: "VideoCategoryViewControllerId")
        
        //VideoCategoryViewControllerId
//        let firstChildTabVC = self.storyboard?.instantiateViewControllerWithIdentifier("FirstMedia3ViewControllerId")
        
        return firstChildTabVC
    }()
    lazy var secondChildTabVC : UIViewController? = {
//      let secondChildTabVC = self.storyboard?.instantiateViewControllerWithIdentifier("SecondMediaViewControllerId")
//      let secondChildTabVC = self.storyboard?.instantiateViewControllerWithIdentifier("RadioStreamViewControllerId")
        //let secondChildTabVC = self.storyboard?.instantiateViewControllerWithIdentifier("AvpRadioId")
        let secondChildTabVC = self.storyboard?.instantiateViewController(withIdentifier: "AudioCategoryViewControllerId")
        
        return secondChildTabVC
    }()
    lazy var thirdChildTabVC : UIViewController? = {
//        let thirdChildTabVC = self.storyboard?.instantiateViewControllerWithIdentifier("ThirdMediaViewControllerId")
        let thirdChildTabVC = self.storyboard?.instantiateViewController(withIdentifier: "PhotoCategoryViewControllerId")
        return thirdChildTabVC
    }()
    
    
    var myIndex:Int = 3
    
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Медиа"

        let defaults = UserDefaults.standard
        let radio_stream_play = defaults.integer(forKey: "radio_stream_play")
        
        if(radio_stream_play == 1)
        {
            appDelegate.radioPlayerMain.stop()
            let defaults = UserDefaults.standard
            defaults.set(0, forKey: "radio_stream_play")
        }


        segmentedControl.selectedSegmentIndex = TabIndex.firstChildTab.rawValue
        displayCurrentTab(TabIndex.firstChildTab.rawValue)
        
        if self.revealViewController() != nil {
            revealViewController().rearViewRevealWidth = 300
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let currentViewController = currentViewController {
            currentViewController.viewWillDisappear(animated)
        }
    }
    
    @IBAction func switchTabs(_ sender: AnyObject) {
        displayCurrentTab(sender.selectedSegmentIndex)
    }
    
    // MARK: - Switching Tabs Functions
    @IBAction func switchTabs1(_ sender: UISegmentedControl) {
        //self.currentViewController!.view.removeFromSuperview()
        //self.currentViewController!.removeFromParentViewController()
        
        //print(sender.selectedSegmentIndex)
        
        displayCurrentTab(sender.selectedSegmentIndex)
    }
    
    func displayCurrentTab(_ tabIndex: Int){
        if let vc = viewControllerForSelectedSegmentIndex(tabIndex) {
            
            self.addChildViewController(vc)
            vc.didMove(toParentViewController: self)
            
            vc.view.frame = self.contentView.bounds
            self.contentView.addSubview(vc.view)
            self.currentViewController = vc
        }
    }
    
    func viewControllerForSelectedSegmentIndex(_ index: Int) -> UIViewController? {

        var vc: UIViewController?
        
        switch index {
        case TabIndex.firstChildTab.rawValue :
            myIndex = TabIndex.firstChildTab.rawValue
            vc = firstChildTabVC
        case TabIndex.secondChildTab.rawValue :
            myIndex = TabIndex.secondChildTab.rawValue
            vc = secondChildTabVC
        case TabIndex.thirdChildTab.rawValue :
            myIndex = TabIndex.thirdChildTab.rawValue
            vc = thirdChildTabVC
        default:
            return nil
        }
        
        
        let defaults = UserDefaults.standard
        defaults.set(myIndex, forKey: "indexTab")
        
        return vc
    }
    
    
    
}
