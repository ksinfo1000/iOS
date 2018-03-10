//
//  New2TableViewCell.swift
//  KozhenSpromozhen
//
//  Created by Kogen on 2/8/17.
//  Copyright © 2017 KozhenSpromozhen. All rights reserved.
//

import UIKit

class New2TableViewCell: UITableViewCell, YTPlayerViewDelegate {

    @IBOutlet weak var player: YTPlayerView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
