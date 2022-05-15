//
//  NewsService.swift
//  NewsApp
//
//  Created by Hishara Dilshan on 2022-02-27.
//

import Foundation
import Combine

enum NetworkError: Error {
    case badUrl
    case responseError
    case invalidData
    case decodingError
    case unknown
}

class NewsService {
    
    static let shared = NewsService()
    
    private init() {}
    
    private var cancellables = Set<AnyCancellable> ()
    
//    func fetchSources(url: URL?, completion: @escaping (Result<[NewsSource], NetworkError>) -> Void) {
//        guard let url = url else {
//            completion(.failure(.badUrl))
//            return
//        }
//
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            guard let data = data, error == nil else {
//                completion(.failure(.invalidData))
//                return
//            }
//            
//            let newsSources = try? JSONDecoder().decode(NewsSourcesResponse.self, from: data)
//            completion(.success(newsSources?.sources ?? []))
//        }.resume()
//    }
//    
//    func fetchArticles(by sourceId: String, url: URL?, completion: @escaping (Result<[NewsArticle], NetworkError>) -> Void) {
//        guard let url = url else {
//            completion(.failure(.badUrl))
//            return
//        }
//                
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            guard let data = data, error == nil else {
//                completion(.failure(.invalidData))
//                return
//            }
//            let newsArticles = try? JSONDecoder().decode(NewsArticleResponse.self, from: data)
//            completion(.success(newsArticles?.articles ?? []))
//            return
//        }.resume()
//    }
    
    func getData<T: Decodable>(from url: URL?, type: T.Type) -> Future<T, Error> {
        return Future<T, Error> { promise in
            guard let url = url else {
                return promise(.failure(NetworkError.badUrl))
            }
            
            URLSession.shared.dataTaskPublisher(for: url)
                .tryMap { (data, response) in
                    guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
                        throw NetworkError.responseError
                    }
                    return data
                }
                .decode(type: T.self, decoder: JSONDecoder())
                .receive(on: RunLoop.main)
                .sink { completion in
                    if case let .failure(error) = completion {
                        switch error {
                        case let decodingError as DecodingError:
                            promise(.failure(decodingError))
                        case let apiError as NetworkError:
                            promise(.failure(apiError))
                        default:
                            promise(.failure(NetworkError.unknown))
                        }
                    }
                } receiveValue: { result in
                    promise(.success(result))
                }
                .store(in: &self.cancellables)

        }
    }
}
