//
//  AudioFileTableViewCell.swift
//  Kogen
//
//  Created by Kogen on 10/15/16.
//  Copyright © 2016 Kogen. All rights reserved.
//

import UIKit
import MediaPlayer

protocol ButtonCellDelegate {
    func cellTapped(_ cell: ButtonCell)
}

class ButtonCell: UITableViewCell {

    var buttonDelegate: ButtonCellDelegate?
    
    var radioPlayer:MPMoviePlayerController!
    var audioUrl:URL!
    var myUrl: String = ""

    @IBAction func playButton(_ sender: AnyObject) {

        if let delegate = buttonDelegate {
            delegate.cellTapped(self)
        }

    }

    @IBAction func pause(_ sender: AnyObject) {
        
    }


    @IBOutlet weak var nameLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

        let selectedView = UIView(frame: CGRect.zero)
        selectedView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        selectedBackgroundView  = selectedView
        

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
