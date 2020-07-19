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
    private var isPlaying: Bool = false
    
    private var playerLayer: AVPlayerLayer {
        get {
            return self.layer as! AVPlayerLayer
        }
    }
    
    override public class var layerClass: Swift.AnyClass {
        get {
            return AVPlayerLayer.self
        }
    }
    
    private var player: AVQueuePlayer?
    private var looper: AVPlayerLooper?
    
    private lazy var playButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "play"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(didTapPlayButton), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupInterface()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupInterface() {
        addSubview(playButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            playButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            playButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            playButton.heightAnchor.constraint(equalToConstant: 44),
            playButton.widthAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    func play(url: URL) {
        let item = AVPlayerItem(url: url)
        let player = AVQueuePlayer(playerItem: item)
        self.player = player
        self.looper = AVPlayerLooper(player: player, templateItem: item)
        playerLayer.player = player
    }
    
    @objc
    private func didTapPlayButton() {
        isPlaying.toggle()
        
        if isPlaying {
            player?.play()
            playButton.setImage(UIImage(systemName: "pause"), for: .normal)
        } else {
            player?.pause()
            playButton.setImage(UIImage(systemName: "play"), for: .normal)
        }
    }
}
