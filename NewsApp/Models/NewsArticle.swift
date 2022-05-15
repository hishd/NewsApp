//
//  NewsArticle.swift
//  NewsApp
//
//  Created by Hishara Dilshan on 2022-02-27.
//

import Foundation


struct NewsArticle: Decodable {
    let author: String?
    let title: String
    let description: String?
    let url: String?
    let content: String?
    let publishedAt: String
    let urlToImage: String?
}

struct NewsArticleResponse: Decodable {
    let articles: [NewsArticle]
}
