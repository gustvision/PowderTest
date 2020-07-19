//
//  PlayerView.swift
//  Powder Test
//
//  Created by Charles Bessonnet on 19/07/2020.
//  Copyright © 2020 Charles Bessonnet. All rights reserved.
//

import UIKit
import AVFoundation

class PlayerView: UIView {

    var playerLayer: AVPlayerLayer {
        get {
            return self.layer as! AVPlayerLayer
        }
    }
    
    override public class var layerClass: Swift.AnyClass {
        get {
            return AVPlayerLayer.self
        }
    }
    
    func play(url: URL) {
        let item = AVPlayerItem(url: url)
        let player = AVPlayer(playerItem: item)
        
        playerLayer.player = player
        player.play()
    }
}
