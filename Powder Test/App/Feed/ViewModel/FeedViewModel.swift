//
//  FeedViewModel.swift
//  Powder Test
//
//  Created by Charles Bessonnet on 19/07/2020.
//  Copyright © 2020 Charles Bessonnet. All rights reserved.
//

import UIKit

protocol FeedViewModelDelegate: class {
    func refresh()
    func showError()
}

class FeedViewModel {
    weak var delegate: FeedViewModelDelegate?
    
    let feedService: FeedService
    var cellViewModels = [FeedCellViewModel]()
    
    init() {
        feedService = FeedService()
    }
    
    
    func fetch() {
        feedService.fetch(completion: { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case let .success(videos):
                self.cellViewModels = videos.map{ FeedCellViewModel(feedVideo: $0) }
                self.delegate?.refresh()
            case .failure:
                self.delegate?.showError()
            }
        })
    }
}
