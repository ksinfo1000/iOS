//
//  detailPardViewController.swift
//  Kogen
//
//  Created by Kogen on 12/2/17.
//  Copyright © 2017 KozhenSpromozhen. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class detailPardViewController: UITableViewController {

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
    
    @IBOutlet var myTable: UITableView!
    
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
            detailImageView.af_setImage(withURL: url)
            
        }
        
        detailTextView.text = detailText
        detailDataView.text = detailDate
        
        self.shareImageButtonMy.layer.cornerRadius = 8
        
        let deviceID = UIDevice.current.identifierForVendor!.uuidString
        let baseURL = "http://ksinfo1000.com/backend.php/connect/pard_detail?device_id=" + deviceID + "&pard_id="+detailId

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
                myCellHeight = 57
                break
            case 1:
                if detailYoutubeId.characters.count > 0 {
                    myCellHeight = myHeightYT
                }
                else{
                    myCellHeight = myHeightImage
                }
                break
            case 2:
                myCellHeight = 45
                break
            case 3:
                myCellHeight = 240
                break
            default:
                myCellHeight = 44
            break
        }
        
        return CGFloat(myCellHeight)
    }
    
    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
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
