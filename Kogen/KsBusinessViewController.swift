//
//  KsBusinessViewController.swift
//  Kogen
//
//  Created by Kogen on 1/8/18.
//  Copyright © 2018 KozhenSpromozhen. All rights reserved.
//

import UIKit

class KsBusinessViewController: UIViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    

    enum TabIndex : Int {
        case firstChildTab = 0
        case secondChildTab = 1
        case thirdChildTab = 2
        //case fourthChildTab = 3
    }
    
    var currentViewController: UIViewController?
    lazy var firstChildTabVC: UIViewController? = {
        let firstChildTabVC = self.storyboard?.instantiateViewController(withIdentifier: "NewsViewControllerId")
        return firstChildTabVC
    }()
    lazy var secondChildTabVC : UIViewController? = {
        //let secondChildTabVC = self.storyboard?.instantiateViewController(withIdentifier: "VideoCategoryViewControllerIdWithCategory")
        let secondChildTabVC = self.storyboard?.instantiateViewController(withIdentifier: "VideoCategoryViewControllerId")
        return secondChildTabVC
    }()
    lazy var thirdChildTabVC : UIViewController? = {
//        let thirdChildTabVC = self.storyboard?.instantiateViewController(withIdentifier: "AvpRadioId")
        let thirdChildTabVC = self.storyboard?.instantiateViewController(withIdentifier: "AudioCategoryViewControllerIdWithCategory")
        return thirdChildTabVC
    }()
/*
    lazy var fourthChildTabVC : UIViewController? = {
        //let fourthChildTabVC = self.storyboard?.instantiateViewController(withIdentifier: "AudioCategoryViewControllerIdWithCategory")
        let fourthChildTabVC = self.storyboard?.instantiateViewController(withIdentifier: "AvpRadioId")
        return fourthChildTabVC
    }()
*/
    var myIndex:Int = 3
    
    
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "KS Business"
        
        defaults.set(2, forKey: "section")
        
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
//        case TabIndex.fourthChildTab.rawValue :
//            myIndex = TabIndex.fourthChildTab.rawValue
//            vc = fourthChildTabVC
        default:
            return nil
        }

        let defaults = UserDefaults.standard
        defaults.set(myIndex, forKey: "indexTab")
        
        return vc
    }
}
