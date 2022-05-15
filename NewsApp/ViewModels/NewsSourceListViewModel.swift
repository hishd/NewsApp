//
//  NewsSourceListViewModel.swift
//  NewsApp
//
//  Created by Hishara Dilshan on 2022-02-27.
//

import Foundation


class NewsSourcesListViewModel: ObservableObject {
    @Published var newsSources: [NewsSource] = []
    
    func getSources(refresh: Bool = false) {
        if refresh {
            newsSources.removeAll()
        }
        NewsService.shared.fetchSources(url: Constants.Urls.sources) { result in
            switch result {
            case .success(let sources):
                DispatchQueue.main.async {
                    self.newsSources = sources
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
