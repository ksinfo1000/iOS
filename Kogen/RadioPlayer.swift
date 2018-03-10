import Foundation
import AVFoundation

class RadioPlayer {
    static let sharedInstance = RadioPlayer()

     var player = AVPlayer(url: URL(string: "http://online-hitfm.tavrmedia.ua/HitFM")!)
     var isPlaying = false
    
    func play() {
        player.play()
        isPlaying = true
    }
    
    func pause() {
        player.pause()
        isPlaying = false
    }
    
    func toggle() {
        if isPlaying == true {
            pause()
        } else {
            play()
        }
    }
    
    func currentlyPlaying() -> Bool {
        return isPlaying
    }
}
