//
//  PardTableViewCell.swift
//  Kogen
//
//  Created by Kogen on 12/2/17.
//  Copyright © 2017 KozhenSpromozhen. All rights reserved.
//

import UIKit

class PardTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var myDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
