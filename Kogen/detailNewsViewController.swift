//
//  detailNewsViewController.swift
//  Kogen
//
//  Created by Kogen on 9/26/16.
//  Copyright © 2016 Kogen. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class detailNewsViewController: UITableViewController {

    @IBOutlet weak var detailNameView: UILabel!
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var detailDataView: UILabel!
    
    @IBOutlet weak var player: YTPlayerView!
    
    @IBOutlet weak var shareImageButtonMy: UIButton!
    @IBAction func shareImageButton(_ sender: Any) {
        if (self.detailYoutubeId.characters.count > 0){
            let youtube = "https://www.youtube.com/watch?v="+detailYoutubeId
            self.myshare(shareText: youtube, shareImage:UIImage())
        }
        else{
            let data = try? Data(contentsOf: URL(string: detailImageOrigin)!)
            let imageToShare = UIImage(data:data!)
            //let imageToShare = UIImage(named: "User")
            self.myshare(shareText: detailYoutubeId, shareImage: imageToShare)
        }
    }
    
    var detailId = ""
    var detailName = ""
    var detailImage = ""
    var detailImageOrigin = ""
    var detailDate = ""
    var detailText = ""
    var detailYoutubeId = ""
    var info = ""
    var myHeightImage = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailNameView.text = detailName
        
        if (detailYoutubeId.characters.count > 0){
            detailImageView.isHidden = true
            player.load(withVideoId: detailYoutubeId)
        }
        else{
            player.isHidden = true
            
            
            
            let url = URL(string: detailImage)!
            
            let realWidth = Double(UIScreen.main.bounds.width)
            myHeightImage = realWidth / Double(info)!
            let size = CGSize(width: realWidth, height: myHeightImage)
            let filter = ScaledToSizeFilter(size: size)
            detailImageView.af_setImage(
                withURL: url,
                filter: filter
            )

//            let url = URL(string: detailImage)!
//            detailImageView.af_setImage(withURL: url)
   
            
        }
        
        detailTextView.text = detailText
        detailDataView.text = detailDate
        
        self.shareImageButtonMy.layer.cornerRadius = 8
        
        let deviceID = UIDevice.current.identifierForVendor!.uuidString
        let baseURL = "http://ksinfo1000.com/backend.php/connect_ks/news_detail?device_id=" + deviceID + "&section_news_id="+detailId
        Alamofire.request(baseURL).responseJSON { response in }
    }

    //var myHeightImage = 0
    var myHeightYT = 0
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if detailYoutubeId.characters.count == 0 {
//            let actualWidth =   detailImageView.frame.width
//            let actualHeight =  detailImageView.frame.height
//
//            let realWidth = UIScreen.main.bounds.width
//            let realHeight = realWidth * (actualHeight/actualWidth)
//            myHeightImage = Int(realHeight)
//            detailImageView.frame = CGRect(x: 0, y: 0, width: realWidth, height: realHeight)
        }
        else{
            let actualWidthYT =   player.frame.width
            let actualHeightYT =  player.frame.height
            
            let realWidthYT = UIScreen.main.bounds.width
            let realHeightYT = realWidthYT * (actualHeightYT/actualWidthYT)
            myHeightYT = Int(realHeightYT)
            player.frame = CGRect(x: 0, y: 0, width: realWidthYT, height: realHeightYT)
        }
    }
    
    var record : NSArray = NSArray()
    var  hight: CGFloat = 0.0
    
    @IBOutlet weak var textHeight: NSLayoutConstraint!
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        record = ["" ,"","","\(detailText)"];
        
        var myCellHeight = 0
        switch indexPath.row {
                    case 0:
                        myCellHeight = 57
                        break
                    case 1:
                        if detailYoutubeId.characters.count > 0 {
                            myCellHeight = myHeightYT
                        }
                        else{
                            myCellHeight = Int(myHeightImage)
                        }
                        break
                    case 2:
                        myCellHeight = 45
                        break
                    case 3:
                        self.hight = self.findHeightForText(text: self.record.object(at: indexPath.row) as! String, havingWidth: self.view.frame.size.width, andFont: UIFont.systemFont(ofSize: 14.0)).height
                        
                        self.detailTextView.contentSize.height = self.hight
                        myCellHeight = Int(self.hight) + 220
                        textHeight.constant = self.hight + 220
                        
                        break
                    default:
                        myCellHeight = 44
                    break
        }
        return CGFloat(myCellHeight)
    }

    func findHeightForText(text: String, havingWidth widthValue: CGFloat, andFont font: UIFont) -> CGSize {
        var size = CGSize.zero
        if text.isEmpty == false {
            let frame = text.boundingRect(with: CGSize(width: widthValue, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
            size = CGSize(width: frame.size.width, height: ceil(frame.size.height))//CGSizeMake(frame.size.width, ceil(frame.size.height))
        }
        return size
    }
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        var myCellHeight = 0
//        switch indexPath.row {
//        case 0:
//            myCellHeight = 57
//            break
//        case 1:
//            if detailYoutubeId.characters.count > 0 {
//                myCellHeight = myHeightYT
//            }
//            else{
//                myCellHeight = myHeightImage
//            }
//            break
//        case 2:
//            myCellHeight = 45
//            break
//        case 3:
//            myCellHeight = 240
//            break
//        default:
//            myCellHeight = 44
//            break
//        }
//
//        return CGFloat(myCellHeight)
//    }
    func myshare(shareText shareText:String?,shareImage:UIImage?){
        
        var objectsToShare = [AnyObject]()
        
        if let shareTextObj = shareText{
            objectsToShare.append(shareTextObj as AnyObject)
        }
        
        if (self.detailYoutubeId.characters.count == 0){
            if let shareImageObj = shareImage{
                objectsToShare.append(shareImageObj)
            }
        }
        
        if shareText != nil {
            let activityViewController = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            
            present(activityViewController, animated: true, completion: nil)
        }else{
            print("There is nothing to share")
        }
    }

}
