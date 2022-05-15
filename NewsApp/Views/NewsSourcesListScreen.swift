//
//  ContentView.swift
//  NewsApp
//
//  Created by Hishara Dilshan on 2022-02-27.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var newsSourcesListViewModel = NewsSourcesListViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if newsSourcesListViewModel.newsSources.count == 0 {
                    ProgressView("Loading...")
                        .frame(maxWidth: 100, maxHeight: 100)
                } else {
                    List(newsSourcesListViewModel.newsSources, id: \.id) { newsSource in
                        NavigationLink(destination: NewsArticlesListScreen(newsSource: newsSource)
                                        .navigationTitle(newsSource.name)
                                        .navigationBarTitleDisplayMode(.inline)) {
                            NewsSourceCell(newsSource: newsSource)
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .onAppear {
                newsSourcesListViewModel.getSources()
            }
            .navigationTitle("Sources")
            .toolbar {
                Button {
                    //refresh the news sources
                    newsSourcesListViewModel.getSources(refresh: true)
                } label: {
                    Image(systemName: "arrow.clockwise.circle")
                }
            }
        }
    }
}

struct NewsSourceCell: View {
    
    let newsSource: NewsSource
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(newsSource.name)
                .font(.headline)
            Text(newsSource.description)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 11")
    }
}
