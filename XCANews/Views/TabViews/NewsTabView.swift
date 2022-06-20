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
                .onChange(of: newsVM.selectedCategory, perform: { _ in
                    loadArticles()
                })
                .navigationTitle(newsVM.selectedCategory.title)
                .navigationBarItems(trailing: menu)
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
                loadArticles()
            })
        default:
            EmptyView()
        }
    }
    
    @ViewBuilder
    private var menu: some View {
        Menu(content: {
            Picker("Category",
                   selection: $newsVM.selectedCategory,
                   content: {
                ForEach(Category.allCases) {
                    Text($0.title).tag($0)
                }
            })
        }, label: {
            Image(systemName: "fibrechannel").imageScale(.large)
        })
    }
}

struct NewsTabView_Previews: PreviewProvider {
    private static let stubArticles = Article.stubItems
    private static let newsVm = NewsViewModel(articles: stubArticles, networkService: NetworkService())
    @StateObject static private var bookmarksVM = BookmarksViewModel()
                                         
    static var previews: some View {
        NewsTabView(newsVM: newsVm)
            .environmentObject(bookmarksVM)
    }
}
