//
//  detailViewController.swift
//  Kogen
//
//  Created by Kogen on 8/8/16.
//  Copyright © 2016 Kogen. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class detailViewController: UITableViewController {
    
    @IBOutlet weak var detailСityView: UILabel!
    @IBOutlet weak var detailNameView: UILabel!
    
    @IBOutlet weak var detailImageView: UIImageView!
    
    @IBOutlet weak var detailDateView: UILabel!
    @IBOutlet weak var detailTimeView: UILabel!
    @IBOutlet weak var detailAddressView: UITextView!
    
    @IBOutlet weak var detailTextView: UITextView!
    
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
    //detailAddressView
    var detailId = ""
    var detailСity = ""
    var detailName = ""
    var detailImage = ""
    var detailImageOrigin = ""
    
    var detailText = ""

    var detailDate = ""
    var detailTime = ""
    var detailAddress = ""
   
    var detailYoutubeId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = detailСity
        detailСityView.text = detailСity
        detailNameView.text = detailName
        
        if (detailYoutubeId.characters.count > 0){
            detailImageView.isHidden = true
            player.load(withVideoId: detailYoutubeId)
        }
        else{
            player.isHidden = true
            let url = URL(string: detailImage)!
            detailImageView.af_setImage(withURL: url)
        }
        
        detailDateView.text = detailDate
        detailTimeView.text = detailTime
        detailAddressView.text = detailAddress
        
        detailTextView.text = detailText
        let contentSize = detailTextView.sizeThatFits(detailTextView.bounds.size)
        var frame = detailTextView.frame
        frame.size.height = contentSize.height
        detailTextView.frame = frame
        
        self.shareImageButtonMy.layer.cornerRadius = 8
        
        let deviceID = UIDevice.current.identifierForVendor!.uuidString
        let baseURL = "http://ksinfo1000.com/backend.php/connect/affiche_detail?device_id=" + deviceID + "&news_id="+detailId
        Alamofire.request(baseURL).responseJSON { response in }
    }
    
    var myHeightImage = 0
    var myHeightYT = 0
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if detailYoutubeId.characters.count == 0 {
            let actualWidth =   detailImageView.frame.width
            let actualHeight =  detailImageView.frame.height
            
            let realWidth = UIScreen.main.bounds.width
            let realHeight = realWidth * (actualHeight/actualWidth)
            myHeightImage = Int(realHeight)
            detailImageView.frame = CGRect(x: 0, y: 0, width: realWidth, height: realHeight)
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
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var myCellHeight = 0
        switch indexPath.row {
        case 0:
            myCellHeight = 44
            break
        case 1:
            myCellHeight = 45
            break
        case 2:
            if detailYoutubeId.characters.count > 0 {
                myCellHeight = myHeightYT
            }
            else{
                myCellHeight = myHeightImage
            }
            break
        case 3:
            myCellHeight = 300
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
