//
//  NewsTabView.swift
//  XCANews
//
//  Created by Roman Rybachenko on 08.06.2022.
//

import SwiftUI

struct NewsTabView: View {
    @StateObject var newsVM: NewsViewModel
    
    var body: some View {
        NavigationView(content: {
            ArticleListView(articles: articles)
                .overlay(content: { overlayView })
                .refreshable(action: {
                    loadArticles()
                })
                .onAppear(perform: {
                    loadArticles()
                })
                .navigationTitle(newsVM.selectedCategory.title)
        })
    }
    
    private var articles: [Article] {
        switch newsVM.state {
        case .success(let articles):
            return articles
            
        default:
            return []
        }
    }
    
    private func loadArticles() {
        Task {
            await newsVM.loadArticles()
        }
    }
    
    @ViewBuilder
    private var overlayView: some View {
        switch newsVM.state {
        case .loading:
            ProgressView()
        case .success(let articles) where articles.isEmpty:
            EmptyListView(text: "No articles found", image: Image(systemName: "exclamationmark.square"))
        case .failure(let error):
            RetryView(infoText: error.localizedDescription,
                      buttonTitle: "Try again",
                      tapAction: {
                // TODO: handle retry action
                pl("refresh data")
            })
        default:
            EmptyView()
        }
    }
}

struct NewsTabView_Previews: PreviewProvider {
    private static let stubArticles = Article.stubItems
    private static let newsVm = NewsViewModel(articles: stubArticles, networkService: NetworkService())
                                         
    static var previews: some View {
        NewsTabView(newsVM: newsVm)
    }
}
