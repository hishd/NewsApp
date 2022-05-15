//
//  NewsArticleListViewModel.swift
//  NewsApp
//
//  Created by Hishara Dilshan on 2022-02-27.
//

import Foundation

class NewsArticleListViewModel: ObservableObject {
    
    @Published var newsArticles: [NewsArticleListItem] = []
    
    func getNewsArticles(by sourceId: String) {
        NewsService.shared.fetchArticles(by: sourceId, url: Constants.Urls.topHeadlines(by: sourceId)) { result in
            switch result {
            case .success(let articles) :
                DispatchQueue.main.async {
                    self.newsArticles = articles.map(NewsArticleListItem.init)
                }
            case .failure(let error) :
                print(error)
            }
        }
    }
}

struct NewsArticleListItem {
    let id = UUID()
    let item: NewsArticle
}
