//
//  PhotoGallery2ViewController.swift
//  Kogen
//
//  Created by Kogen on 12/4/16.
//  Copyright © 2016 Kogen. All rights reserved.
//

import UIKit
import Alamofire

private let reuseIdentifier = "cell"

class PhotoGallery2ViewController: UICollectionViewController {

    var privateListImg      = [String]()
    var privateList         = [String]()
    var privateListImgFull         = [String]()
    
    @IBOutlet var collectionview: UICollectionView!
    var baseURL = "http://ksinfo1000.com/backend.php/connect/photo"

    
    
    
    func getJSON()
    {
        let url = URL(string: baseURL)
        
        self.privateList = []
        self.privateListImg = []
        self.privateListImgFull = []
        
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
                        if var img_full = contacts["img_full"] {
                            self.privateListImgFull.append(img_full as! String)
                        }
                        
                        self.collectionview.reloadData()
                        
                    }
                }
            }
        }
    }

    
//        func getJSON()
//        {
//            self.privateListImg = []
//    
//            let url = URL(string: baseURL)
//            let request = URLRequest(url: url!)
//            let session = URLSession(configuration: URLSessionConfiguration.default)
//            let task = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
//                if error == nil {
//                    let swiftyJSON = JSON(data: data!)
//                    let privateListArray = swiftyJSON["photos"].arrayValue
//    
//                    DispatchQueue.main.async(execute: {
//                        for contacts in privateListArray
//                        {
//                            let img         = contacts["img"].stringValue
//                            let name        = contacts["name"].stringValue
//                            let img_full    = contacts["img_full"].stringValue
//                            
//                            self.privateList.append(name)
//                            self.privateListImg.append(img)
//                            self.privateListImgFull.append(img_full)
//                            
//                            DispatchQueue.main.async(execute: {
//                                self.collectionview.reloadData()
//                            })
//                        }
//    
//                    })
//    
//                } else {
//                    print("Error url")
//                }
//                
//            }) 
//            task.resume()
//        }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        getJSON()
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return privateListImg.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! Cell2Class
        cell.backgroundColor = UIColor.green

        let data = try? Data(contentsOf: URL(string: privateListImg[indexPath.row])!)
        let myImage = UIImage(data:data!)

        cell.thumbnailImageView!.image = myImage

        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        self.performSegue(withIdentifier: "showImage", sender: self)
    }
    
    func backButtonAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showImage" {

            let indexPaths = self.collectionView!.indexPathsForSelectedItems
            let indexPath = indexPaths![0] as IndexPath

            let vc = segue.destination as! NewViewController
            
            vc.image = privateListImgFull[indexPath.row]
            vc.name = privateList[indexPath.row]
            
            //vc.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Назад", style: .Plain, target: self, action: #selector(self.backButtonAction))
            
        }
        
    }

//     func collectionView(collectionView: UICollectionView, layout collectionViewLayot: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
//        let size = CGSize(width: 100, height: 100)
//        return size
//    }
    
}
