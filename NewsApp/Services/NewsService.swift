//
//  NewsService.swift
//  NewsApp
//
//  Created by Hishara Dilshan on 2022-02-27.
//

import Foundation

enum NetworkError: Error {
    case badUrl
    case invalidData
    case decodingError
}

class NewsService {
    func fetchSources(url: URL?, completion: @escaping (Result<[NewsSource], NetworkError>) -> Void) {
        guard let url = url else {
            completion(.failure(.badUrl))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.invalidData))
                return
            }
            
            let newsSources = try? JSONDecoder().decode(NewsSourcesResponse.self, from: data)
            completion(.success(newsSources?.sources ?? []))
        }.resume()
    }
    
    func fetchArticles(by sourceId: String, url: URL?, completion: @escaping (Result<[NewsArticle], NetworkError>) -> Void) {
        guard let url = url else {
            completion(.failure(.badUrl))
            return
        }
                
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.invalidData))
                return
            }
            let newsArticles = try? JSONDecoder().decode(NewsArticleResponse.self, from: data)
            completion(.success(newsArticles?.articles ?? []))
            return
        }.resume()
    }
}
