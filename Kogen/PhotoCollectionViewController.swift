//
//  PhotoCollectionViewController.swift
//  KozhenSpromozhen
//
//  Created by Kogen on 2/10/17.
//  Copyright © 2017 KozhenSpromozhen. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class PhotoCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    let defaults = UserDefaults.standard
    
    var categoryId  = ""
    var sectionId = Int()
    
    @IBOutlet weak var collectionview: UICollectionView!
    
    var privateListImg          = [String]()
    var privateList             = [String]()
    var privateListImgFull      = [String]()
    var privateListImgOrigin    = [String]()
    var privateListInfo         = [String]()
    
    @IBOutlet weak var collectionPhotoView: UICollectionView!

    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    var baseURL = "http://ksinfo1000.com/backend.php/connect_ks/photo"
    
    var myWidth = Float()
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var num = 0.0
        
        switch UIScreen.main.bounds.width {
        case 768.0:
            num = 7.0
        case 1024.0:
            num = 9.0
        default:
            num = 4.0
        }
        
        if UIScreen.main.bounds.width > UIScreen.main.bounds.height && num == 4.0 {
            num = 5.0
        }
        if UIScreen.main.bounds.width > UIScreen.main.bounds.height && num == 6.0 {
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
        let url = URL(string: baseURL + "?category_id="+categoryId+"&section_id=" + String(sectionId))

        Alamofire.request(url!).responseJSON { response in
            if let value = response.result.value as? [String: AnyObject] {
                if let posts = value["photos"] as? [[String: AnyObject]]
                {
                    for contacts in posts
                    {
                        if var name = contacts["name"] {
                            self.privateList.append(name as! String)
                        }
                        if var img = contacts["img"] {
                            self.privateListImg.append(img as! String)
                        }
                        if var img_full = contacts["img_full1"] {
                            self.privateListImgFull.append(img_full as! String)
                        }
                        if var img_origin = contacts["img_origin"] {
                            self.privateListImgOrigin.append(img_origin as! String)
                        }
                        if var img_info = contacts["info"] {
                            self.privateListInfo.append(img_info as! String)
                        }
                    }
                    self.collectionPhotoView.reloadData()
                }
            }
        }
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        if UIScreen.main.bounds.width <= 736
        {
            if UIDevice.current.orientation.isLandscape {
                self.topConstraint.constant = 10
            } else {
                self.topConstraint.constant = 10
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getJSON()
        if UIDevice.current.orientation.isLandscape && UIScreen.main.bounds.width <= 736 {
            self.topConstraint.constant = 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return privateListImg.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PhotoCollectionViewCell
        
        let url = URL(string: privateListImg[indexPath.row])!
        cell.thumbnailImageView.af_setImage(withURL: url)

        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        self.performSegue(withIdentifier: "showPhoto", sender: self)
//    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPhoto"
        {
            let indexPaths = self.collectionPhotoView!.indexPathsForSelectedItems!
            let indexPath = indexPaths[0] as IndexPath

            let vc = segue.destination as! PhotoViewController
            
            vc.image = privateListImgFull[indexPath.row]
            vc.name = privateList[indexPath.row]
            vc.image_origin = privateListImgOrigin[indexPath.row]
            vc.info = privateListInfo[indexPath.row]
        }
    }
    
}
