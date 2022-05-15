//
//  NewsArticlesListScreen.swift
//  NewsApp
//
//  Created by Hishara Dilshan on 2022-02-27.
//

import SwiftUI

struct NewsArticlesListScreen: View {
    
    let newsSource: NewsSource
    @StateObject private var newsArticleListViewModel = NewsArticleListViewModel()
    
    var body: some View {
        VStack {
            List(newsArticleListViewModel.newsArticles, id: \.id) { article in
                NewsArticleCell(newsArticle: article.item)
            }
            .listStyle(.plain)
            .onAppear {
                newsArticleListViewModel.getNewsArticles(by: newsSource.id)
            }
        }
    }
}

struct NewsArticleCell: View {
    
    let newsArticle: NewsArticle
    
    var body: some View {
        HStack(alignment: .top) {
            AsyncImage(url: URL(string: newsArticle.urlToImage ?? "")) { image in
                image.resizable()
                    .frame(maxWidth: 100, maxHeight: 100)
                    .cornerRadius(10)
            } placeholder: {
                ProgressView("Loading...")
                    .frame(maxWidth: 100, maxHeight: 100)
            }
            
            VStack(alignment: .leading) {
                Text(newsArticle.title)
                    .fontWeight(.bold)
                Text(newsArticle.description ?? "")
            }
        }
    }
}

struct NewsArticlesListScreen_Previews: PreviewProvider {
    static var previews: some View {
        NewsArticlesListScreen(newsSource: NewsSource(id: "ID", name: "Name", description: "Description"))
            .previewDevice("iPhone 11")
    }
}
