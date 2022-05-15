//
//  NewsSourceListViewModel.swift
//  NewsApp
//
//  Created by Hishara Dilshan on 2022-02-27.
//

import Foundation
import Combine

class NewsSourcesListViewModel: ObservableObject {
    @Published var newsSources: [NewsSource] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    func getSources(refresh: Bool = false) {
        if refresh {
            newsSources.removeAll()
        }
//        NewsService.shared.fetchSources(url: Constants.Urls.sources) { result in
//            switch result {
//            case .success(let sources):
//                DispatchQueue.main.async {
//                    self.newsSources = sources
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
        
        NewsService.shared.getData(from: Constants.Urls.sources, type: NewsSourcesResponse.self)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error.localizedDescription)
                case .finished:
                    print("Finished Loading")
                }
            } receiveValue: { [weak self] response in
                self?.newsSources = response.sources
            }
            .store(in: &cancellables)

    }
}
