//
//  FeedCellViewModel.swift
//  Powder Test
//
//  Created by Charles Bessonnet on 19/07/2020.
//  Copyright © 2020 Charles Bessonnet. All rights reserved.
//

import UIKit

class FeedCellViewModel {
    let id: Int
    let videoURL: URL
    let title: String
    let game: String
    let author: String
    
    init(feedVideo: FeedVideo) {
        self.id = feedVideo.id
        self.videoURL = feedVideo.videoURL
        self.title = feedVideo.title
        self.game = feedVideo.game
        self.author = feedVideo.author
    }
}
