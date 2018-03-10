//
//  AvpRadioViewCell.swift
//  Kogen
//
//  Created by Kogen on 11/22/16.
//  Copyright © 2016 Kogen. All rights reserved.
//

import UIKit

protocol AvpRadioCellDelegate {
    func cellTapped(_ cell: AvpRadioViewCell)
}

class AvpRadioViewCell: UITableViewCell {
    
    var buttonDelegate: AvpRadioCellDelegate?
    
    @IBOutlet weak var play_options: UIButton!
    @IBOutlet weak var pause_options: UIButton!
    
    @IBAction func playAction(_ sender: AnyObject) {
        if let delegate = buttonDelegate {
            delegate.cellTapped(self)
        }
    }
    
    @IBOutlet weak var name: UILabel!
    var myUrl: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
