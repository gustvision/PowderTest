//
//  FeedViewModel.swift
//  Powder Test
//
//  Created by Charles Bessonnet on 19/07/2020.
//  Copyright © 2020 Charles Bessonnet. All rights reserved.
//

import UIKit

class FeedViewModel {
    let feedService: FeedService
    
    init() {
        feedService = FeedService()
    }
    
    
    func fetch() {
        feedService.fetch()
    }
}
