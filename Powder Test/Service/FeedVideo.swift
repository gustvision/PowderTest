//
//  FeedVideo.swift
//  Powder Test
//
//  Created by Charles Bessonnet on 19/07/2020.
//  Copyright © 2020 Charles Bessonnet. All rights reserved.
//

import UIKit

struct FeedVideo: Codable {
    let id: Int
    let videoURL: URL
    let title: String
    let game: String
    let author: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case videoURL = "videoUrl"
        case title
        case game
        case author
    }
}
