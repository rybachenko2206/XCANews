//
//  ContentView.swift
//  XCANews
//
//  Created by Roman Rybachenko on 31.05.2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var newsViewModel: NewsViewModel

    var body: some View {
        TabView(content: {
            NewsTabView(newsVM: newsViewModel)
                .tabItem({
                    Label("News", systemImage: "newspaper")
                })
            
            BookmarksTabView()
                .tabItem({
                    Label("Bookmarks", systemImage: "bookmark")
                })
        })
    }
}


struct ContentView_Previews: PreviewProvider {
    private static let stubArticles = Article.stubItems
    private static let newsVm = NewsViewModel(articles: stubArticles, networkService: NetworkService())
    
    static var previews: some View {
        ContentView(newsViewModel: newsVm)
    }
}
