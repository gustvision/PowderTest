//
//  FeedService.swift
//  Powder Test
//
//  Created by Charles Bessonnet on 19/07/2020.
//  Copyright © 2020 Charles Bessonnet. All rights reserved.
//

import UIKit

class FeedService {
    let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    
    func fetch(completion: @escaping (Result<[FeedVideo], Error>) -> Void) {
        guard let url = URL(string: "https://firebasestorage.googleapis.com/v0/b/powder-c9282.appspot.com/o/test%2Fstatic_feed.json?alt=media&token=c5bbde3a-129b-449e-a79e-d2a0ccffbd0f")
        else {
            print("not valid")
            return
        }
        
        networkManager.request(url: url) { result in
            switch result {
            case let .success(data):
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                do {
                    let videos = try decoder.decode([FeedVideo].self, from: data)
                    completion(.success(videos))
                } catch let error {
                    completion(.failure(error))
                }
                
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
