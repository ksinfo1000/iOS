//
//  ContestTableViewCell.swift
//  KozhenSpromozhen
//
//  Created by Kogen on 7/12/17.
//  Copyright © 2017 KozhenSpromozhen. All rights reserved.
//

import UIKit

class ContestTableViewCell: UITableViewCell {

    @IBOutlet weak var nameContest: UILabel!
    
    @IBOutlet weak var imageContest: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
