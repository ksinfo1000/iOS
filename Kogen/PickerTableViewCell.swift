//
//  PickerTableViewCell.swift
//  KozhenSpromozhen
//
//  Created by Kogen on 7/14/17.
//  Copyright © 2017 KozhenSpromozhen. All rights reserved.
//

import UIKit

class PickerTableViewCell: UITableViewCell, YTPlayerViewDelegate {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var countVoteLabel: UILabel!
    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var personText: UITextView!
    @IBOutlet weak var privateListPresent: UIImageView!
    @IBOutlet weak var voteImage: UIImageView!

    @IBOutlet weak var player: YTPlayerView!
    
    @IBOutlet weak var voteButton1: UIButton!
    
    @IBAction func buttonVote(_ sender: Any) {
        
//        let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: UIAlertControllerStyle.alert)
//        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
//        self.presentViewController(alert, animated: true, completion: nil)
    }
    class var expandedHeight: CGFloat {get {return 200}}
    class var defaultHeight: CGFloat {get {return 44}}
    
//    override func layoutSubviews() {
//        personImage.bounds
//    }
    
    func checkHeight(){
        //datePicker.isHidden = (frame.size.height<PickerTableViewCell.expandedHeight)
    }
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
