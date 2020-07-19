//
//  NewtorkManager.swift
//  Powder Test
//
//  Created by Charles Bessonnet on 19/07/2020.
//  Copyright © 2020 Charles Bessonnet. All rights reserved.
//

import UIKit

import UIKit

enum HTTPMethod: String {
    case POST
    case GET
}

enum NetworkManagerError: Error {
    case badURL
    case dataInvalid
    case backendError
    case tooManyRequests
}

class NetworkManager {
    let defaultSession = URLSession(configuration: .default)
    let decoder = JSONDecoder()
    
    static let shared = NetworkManager()
    
    private init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    @discardableResult
    func request(url: URL, body: [String: Any]? = nil, httpMethod: HTTPMethod = .GET, completion: @escaping (Result<Data, Error>) -> Void) -> URLSessionDataTask? {
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.httpBody = generateData(from: body)
        
        var dataTask: URLSessionDataTask?
        
        dataTask = defaultSession.dataTask(with: request, completionHandler: { (data, reponse, error) in
            guard   error == nil,
                let data = data,
                let statusCode = (reponse as? HTTPURLResponse)?.statusCode
                else {
                    completion(.failure(NetworkManagerError.dataInvalid))
                    return
            }
            
            if statusCode == 200 {
                completion(.success(data))
            } else if statusCode == 401 {
                completion(.failure(NetworkManagerError.backendError))
            } else {
                completion(.failure(NetworkManagerError.backendError))
            }
        })
        
        dataTask?.resume()
        return dataTask
    }
    
    private func generateData(from body: [String: Any]?) -> Data? {
        guard let body = body else { return nil }
        let jsonData = try? JSONSerialization.data(withJSONObject: body)
        return jsonData
    }
}
