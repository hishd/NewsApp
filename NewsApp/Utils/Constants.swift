//
//  Constants.swift
//  NewsApp
//
//  Created by Hishara Dilshan on 2022-02-27.
//

import Foundation


struct Constants {
    struct Urls {
        static func topHeadlines(by source: String) -> URL? {
            return URL(string: "https://newsapi.org/v2/top-headlines?sources=\(source)&apiKey=be760542344c40aea478222f2a52de28")
        }
        static let sources: URL? = URL(string: "https://newsapi.org/v2/sources?apiKey=be760542344c40aea478222f2a52de28")
    }
}
