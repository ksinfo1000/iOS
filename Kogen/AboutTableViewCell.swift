//
//  AboutTableViewCell.swift
//  Kogen
//
//  Created by Kogen on 8/11/16.
//  Copyright © 2016 Kogen. All rights reserved.
//

import UIKit

class AboutTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameView: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var imgView: UIImageView!
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
