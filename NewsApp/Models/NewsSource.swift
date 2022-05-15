//
//  NewsSource.swift
//  NewsApp
//
//  Created by Hishara Dilshan on 2022-02-27.
//

import Foundation


struct NewsSource: Decodable {
    let id: String
    let name: String
    let description: String
}

struct NewsSourcesResponse: Decodable {
    let sources: [NewsSource]
}
