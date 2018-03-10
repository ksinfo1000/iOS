//
//  ThirdTableViewCell.swift
//  Kogen
//
//  Created by Kogen on 10/26/16.
//  Copyright © 2016 Kogen. All rights reserved.
//

import UIKit

class ThirdTableViewCell: UITableViewCell,YTPlayerViewDelegate{

    @IBOutlet weak var player: YTPlayerView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

//    func playerView(playerView: YTPlayerView!, didChangeToState state: YTPlayerState) {
//        switch(state) {
//        case YTPlayerState.Unstarted:
//            print("Unstarted")
//            break
//        case YTPlayerState.Queued:
//            print("Ready to play")
//            break
//        case YTPlayerState.Playing:
//            print("Video playing")
//            break
//        case YTPlayerState.Paused:
//            print("Video paused")
//            break
//        default:
//            break
//        }
//        
//    }
    
}
