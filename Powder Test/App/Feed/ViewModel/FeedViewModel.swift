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
                let viewModels = videos.map{ FeedCellViewModel(feedVideo: $0) }
                
                if viewModels.count >= 2, let first = viewModels.first, let last = viewModels.last {
                    self.cellViewModels = [last] + viewModels + [first]
                } else {
                    self.cellViewModels = viewModels
                }
                
                self.delegate?.refresh()
            case .failure:
                self.delegate?.showError()
            }
        })
    }
}
