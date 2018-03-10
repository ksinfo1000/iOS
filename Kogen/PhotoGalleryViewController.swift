//
//  PhotoGalleryViewController.swift
//  Kogen
//
//  Created by Kogen on 12/4/16.
//  Copyright © 2016 Kogen. All rights reserved.
//

import UIKit

//class PhotoGalleryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    class PhotoGalleryViewController: UICollectionViewController {
    


//    var images_cache = [String:UIImage]()
//    var images = [String]()
//    let link = "http://www.kaleidosblog.com/tutorial/get_images.php"
//    var baseURL = "http://ksinfo1000.com/backend.php/connect/post"
//    
//    var privateListImg      = [String]()
    
        

        
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//        
//        layout.itemSize = CGSize(width: 120,height: 120)
//        
//        
//        self.collectionview.setCollectionViewLayout(layout, animated: true)
        
//        getJSON()
        
//        collectionview.delegate = self
//        collectionview.dataSource = self
        
    }

        override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 100
        }
        
        override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            //cell.backgroundColor = UIColor.greenColor()
            return cell
        }
        
//    
//    internal func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
//    {
//        return privateListImg.count
//    }
//    
//    
//
//    internal func collectionView(collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
//    {
//        let cell:CellClass = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CellClass
//        
//        if (images_cache[images[indexPath.row]] != nil)
//        {
//            cell.Image.image = images_cache[images[indexPath.row]]
//        }
//        else
//        {
//            //load_image(images[indexPath.row], imageview:cell.Image)
//        }
//        
//        return cell
//    }
//    
//    
//    
//    internal func numberOfSections(in collectionView: UICollectionView) -> Int
//    {
//        return 1
//    }
//    
//
//    
//    
////    func extract_json_data(_ data:NSString)
////    {
////        let jsonData:Data = data.data(using: String.Encoding.ascii.rawValue)!
////        let json: AnyObject?
////        
////        do
////        {
////            
////            
////                      json = try JSONSerialization.jsonObject (with: jsonData, options: [])
////            //json = try JSONSerialization.jsonObject(with: jsonData, options:[]) as AnyObject
////            
////        }
////        catch
////        {
////            print("error")
////            return
////        }
////        
////        guard let images_array = json! as? NSArray else
////        {
////            print("error")
////            return
////        }
////        
////        for j in 0 ..< images_array.count
////        {
////            images.append(images_array[j] as! String)
////            print(1)
////        }
////        
////        DispatchQueue.main.async(execute: refresh)
////    }
////    
////    
////    
////    func refresh()
////    {
////        self.collectionview.reloadData()
////    }
////    
////    
////    func get_json()
////    {
////        
////        let url:URL = URL(string: link)!
////        let session = URLSession.shared
////        
////        let request = NSMutableURLRequest(url: url)
////        request.timeoutInterval = 10
////        
////        
////        //        let task = session.dataTask(with: request, completionHandler: {
////        //            (
////        //            data, response, error) in
////        let task = session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
////            
////            guard let _:Data = data, let _:URLResponse = response, error == nil else {
////                
////                return
////            }
////            
////            let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
////            
////            self.extract_json_data(dataString!)
////            
////        }
////        
////        task.resume()
////        
////    }
//    
//        func refresh()
//        {
//            self.collectionview.reloadData()
//        }
//    
//    func getJSON()
//    {
//
//        self.privateListImg = []
//
//        
//        let url = NSURL(string: baseURL)
//        let request = NSURLRequest(URL: url!)
//        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
//        let task = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
//            if error == nil {
//                let swiftyJSON = JSON(data: data!)
//                //let theTitle = swiftyJSON["concerts"][0].stringValue
//                let privateListArray = swiftyJSON["posts"].arrayValue
//                
//                dispatch_async(dispatch_get_main_queue(), {
//                    for contacts in privateListArray
//                    {
//
//                        let img         = contacts["img"].stringValue
//
//                        self.privateListImg.append(img)
//
////        DispatchQueue.main.async(execute: refresh)
////                        DispatchQueue.main.async {
////                            self.collectionview.reloadData()
////                        }
//                        
//                                                dispatch_async(dispatch_get_main_queue(),{
//                            self.collectionview.reloadData()
//                                                })
//                        
////                        dispatch_async(dispatch_get_main_queue(),{
////                            self.myTableViewNews.reloadData()
////                        })
//                    }
//                    
//                })
//                
//            } else {
//                print("Error url")
//            }
//            
//        }
//        task.resume()
//    }
    
    
}
