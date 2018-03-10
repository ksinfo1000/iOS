//
//  VideoFileTableViewCell.swift
//  Kogen
//
//  Created by Kogen on 10/15/16.
//  Copyright © 2016 Kogen. All rights reserved.
//

import UIKit

class VideoFileTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
