//
//  PhotoCategoryCollectionViewController.swift
//  KozhenSpromozhen
//
//  Created by Kogen on 2/10/17.
//  Copyright © 2017 KozhenSpromozhen. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class PhotoCategoryCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var baseURL = "http://ksinfo1000.com/backend.php/connect_ks/photo/category"
    
    var privateList     = [String]()
    var privateListId   = [String]()
    var privateListImg      = [String]()

    var privateListCn_r = [String]()
    var privateListCn_g = [String]()
    var privateListCn_b = [String]()
    var privateListClose_name = [String]()
    
    var myWidth = Float()
    
    let defaults = UserDefaults.standard
    var sectionId = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Фото"
        
        if self.revealViewController() != nil {
            revealViewController().rearViewRevealWidth = 300
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        getJSON()
        
        if UIDevice.current.orientation.isLandscape && UIScreen.main.bounds.width <= 736 {
            self.topConstraint.constant = 47
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        var num = 0.0
        
        switch UIScreen.main.bounds.width {
        case 768.0:
            num = 5.0
        case 1024.0:
            num = 5.0
        default:
            num = 3.0
        }
        
        if UIScreen.main.bounds.width > UIScreen.main.bounds.height && num == 3.0 {
            num = 5.0
        }
        if UIScreen.main.bounds.width > UIScreen.main.bounds.height && num == 5.0 {
            num = 6.0
        }
        
        let width = collectionView.frame.width / CGFloat(num) - 2
        
        self.myWidth = Float(width)
        
        return CGSize(width: width, height: width)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2.0
    }

    func getJSON()
    {
        sectionId = defaults.integer(forKey: "section")
        let url = URL(string: (baseURL + "?section_id=" + String(sectionId)))
        
        Alamofire.request(url!).responseJSON { response in
            if let value = response.result.value as? [String: AnyObject] {
                if let posts = value["photo_category"] as? [[String: AnyObject]]
                {
                    for contacts in posts
                    {
                        if var name = contacts["name"] {
                            self.privateList.append(name as! String)
                        }
                        if var category_id = contacts["id"] {
                            self.privateListId.append(category_id as! String)
                        }
                        if var img = contacts["img"] {
                            self.privateListImg.append(img as! String)
                        }
                        if var cn_r = contacts["cn_r"] {
                            self.privateListCn_r.append(cn_r as! String)
                        }
                        if var cn_g = contacts["cn_g"] {
                            self.privateListCn_g.append(cn_g as! String)
                        }
                        if var cn_b = contacts["cn_b"] {
                            self.privateListCn_b.append(cn_b as! String)
                        }
                        if var close_name = contacts["close_name"] {
                            self.privateListClose_name.append(close_name as! String)
                        }
                    }
                    self.collectionView.reloadData()
                }
            }
        }
    }

    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {

        if UIScreen.main.bounds.width <= 736
        {
            if UIDevice.current.orientation.isLandscape {
                self.topConstraint.constant = 47
            } else {
                self.topConstraint.constant = 70
            }
        }
        
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.privateListId.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PhotoCategoryCollectionViewCell

        var my_close = Bool()
        if self.privateListClose_name[indexPath.row].characters.count > 0
        {
            my_close = NSString(string: self.privateListClose_name[indexPath.row]).boolValue
        }
        if !my_close
        {
            cell.titleLabel?.text = self.privateList[indexPath.row]
            var my_red = CGFloat()
            if self.privateListCn_r[indexPath.row].characters.count > 0
            {
                my_red = CGFloat((Double(self.privateListCn_r[indexPath.row])!/255).roundTo3f)
            }
            var my_green = CGFloat()
            if self.privateListCn_r[indexPath.row].characters.count > 0
            {
                my_green = CGFloat((Double(self.privateListCn_g[indexPath.row])!/255).roundTo3f)
            }
            var my_blue = CGFloat()
            if self.privateListCn_r[indexPath.row].characters.count > 0
            {
                my_blue = CGFloat((Double(self.privateListCn_b[indexPath.row])!/255).roundTo3f)
            }
            cell.titleLabel.textColor = UIColor.init(red: my_red, green: my_green, blue: my_blue, alpha: 1)
        }
        else
        {
            cell.titleLabel?.text = ""
        }
        
        cell.top.constant = CGFloat(self.myWidth) * 0.6
        
        let url = URL(string: privateListImg[indexPath.row])!
        cell.thumbnailImageView.af_setImage(withURL: url)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showPhotosByCategory", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPhotosByCategory"
        {
            let indexPaths = self.collectionView!.indexPathsForSelectedItems!
            let indexPath = indexPaths[0] as IndexPath
            
            let vc = segue.destination as! PhotoCollectionViewController
            vc.title = self.privateList[indexPath.row]
            vc.categoryId = self.privateListId[indexPath.row]
            
            vc.sectionId = sectionId
        }
    }
}
