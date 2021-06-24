//
//  APIManager.swift
//  Reddit
//
//  Created by Divya on 24/06/21.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case serverError
    case parsingError
}

class ApiManager {
    static let manager = ApiManager()
    let session = URLSession.shared
    private init() {}
    
    func getData(requestUrl: String, onCompletion: @escaping (Result<RedditData, NetworkError>)->Void) {
        guard let url = URL(string: requestUrl) else {
            onCompletion(.failure(.badURL))
            return
        }
        
        session.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                onCompletion(.failure(.parsingError))
                return
            }
            
            if let receivedData = data {
                do {
                    let feed = try JSONDecoder().decode(Reddit.self, from: receivedData)
                    onCompletion(.success(feed.data))
                } catch {
                    onCompletion(.failure(.serverError))
                }
            }
            
        }.resume()
    }
    
    func downloadImage(url: String, completionHandler: @escaping (Result<(Data, String), NetworkError>) -> Void) {
        guard let imageUrl = URL(string: url) else {
            completionHandler(.failure(.badURL))
            return
        }
        
        session.dataTask(with: imageUrl) { (receivedData, receivedResponse, receivedError) in
            if let data = receivedData {
                completionHandler(.success((data, url)))
            } else {
                completionHandler(.failure(.serverError))
            }
        }.resume()
    }
}

