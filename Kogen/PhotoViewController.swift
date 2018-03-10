//
//  PhotoViewController.swift
//  KozhenSpromozhen
//
//  Created by Kogen on 2/10/17.
//  Copyright © 2017 KozhenSpromozhen. All rights reserved.
//

import UIKit
import AlamofireImage

class PhotoViewController: UITableViewController{

    @IBOutlet   weak var imageView: UIImageView!
    @IBOutlet weak var nameView: UILabel!

    @IBOutlet var myTable: UITableView!

    @IBOutlet weak var shareButtonMy: UIButton!
    @IBAction func shareButton(_ sender: Any) {
        let data = try? Data(contentsOf: URL(string: image_origin)!)
        let imageToShare = UIImage(data:data!)
        //let imageToShare = UIImage(named: "User")
        self.myshare(shareText: "", shareImage: imageToShare)
    }
    var image = ""
    var image_origin = ""
    var name = ""
    var info = ""
    
    var myHeightImage = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myTable.separatorStyle = .none
        
        navigationItem.title = name
        
        
        let url = URL(string: image)!

        let realWidth = Double(UIScreen.main.bounds.width)
        myHeightImage = realWidth / Double(info)!
        let size = CGSize(width: realWidth, height: myHeightImage)
        let filter = ScaledToSizeFilter(size: size)
        imageView.af_setImage(
            withURL: url,
            filter: filter
        )

        //imageView.af_setImage(withURL: url)

        
//        print(imageView.frame.width)
//        print(imageView.frame.height)
        
        self.nameView.text = name
        self.shareButtonMy.layer.cornerRadius = 8

    }

    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var myCellHeight = 0
        switch indexPath.row {
        case 0:
            myCellHeight = Int(myHeightImage)
            break
        case 1:
            myCellHeight = 44
            break
        default:
            myCellHeight = 44
            break
        }
        
        return CGFloat(myCellHeight)
    }

    
    
    func myshare(shareText shareText:String?,shareImage:UIImage?){
        
        var objectsToShare = [AnyObject]()
        
        if let shareTextObj = shareText{
            objectsToShare.append(shareTextObj as AnyObject)
        }
        
        if let shareImageObj = shareImage{
            objectsToShare.append(shareImageObj)
        }
        
        if shareText != nil || shareImage != nil{
            let activityViewController = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            
            present(activityViewController, animated: true, completion: nil)
        }else{
            print("There is nothing to share")
        }
    }
}
