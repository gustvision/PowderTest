//
//  FeedCell.swift
//  Powder Test
//
//  Created by Charles Bessonnet on 19/07/2020.
//  Copyright © 2020 Charles Bessonnet. All rights reserved.
//

import UIKit

class FeedCell: UICollectionViewCell {
    
    private lazy var tittleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 32)
        return label
    }()
    
    private lazy var playerView: PlayerView = {
        let playerView = PlayerView()
        playerView.translatesAutoresizingMaskIntoConstraints = false
        return playerView
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
        backgroundColor = .white
        
        addSubview(playerView)
        addSubview(tittleLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tittleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            tittleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            tittleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            
            tittleLabel.bottomAnchor.constraint(equalTo: playerView.topAnchor, constant: 8),
            
            playerView.leftAnchor.constraint(equalTo: leftAnchor),
            playerView.rightAnchor.constraint(equalTo: rightAnchor),
            playerView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    func setup(viewModel: FeedCellViewModel) {
        tittleLabel.text = viewModel.game
        playerView.play(url: viewModel.videoURL)
    }
    
    func play() {
        playerView.play()
    }
    
    func pause() {
        playerView.pause()
    }
}
