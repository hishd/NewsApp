//
//  NewsArticleListViewModel.swift
//  NewsApp
//
//  Created by Hishara Dilshan on 2022-02-27.
//

import Foundation
import Combine

class NewsArticleListViewModel: ObservableObject {
    
    @Published var newsArticles: [NewsArticleListItem] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    func getNewsArticles(by sourceId: String) {
//        NewsService.shared.fetchArticles(by: sourceId, url: Constants.Urls.topHeadlines(by: sourceId)) { result in
//            switch result {
//            case .success(let articles) :
//                DispatchQueue.main.async {
//                    self.newsArticles = articles.map(NewsArticleListItem.init)
//                }
//            case .failure(let error) :
//                print(error)
//            }
//        }
        
        NewsService.shared.getData(from: Constants.Urls.topHeadlines(by: sourceId), type: NewsArticleResponse.self)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error.localizedDescription)
                case .finished:
                    print("Finished")
                }
            } receiveValue: { [weak self] response in
                self?.newsArticles = response.articles.map(NewsArticleListItem.init)
            }
            .store(in: &cancellables)
    }
}

struct NewsArticleListItem {
    let id = UUID()
    let item: NewsArticle
}
