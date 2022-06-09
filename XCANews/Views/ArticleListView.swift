//
//  ArticleListView.swift
//  XCANews
//
//  Created by Roman Rybachenko on 04.06.2022.
//

import SwiftUI

struct ArticleListView: View {
    let articles: [Article]
    @State private var selectedArticle: Article?
    
    var body: some View {
        List(content: {
            ForEach(articles, content: { article in
                ArticleRowView(article: article)
                    .onTapGesture {
                        selectedArticle = article
                    }
            })
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            .listRowSeparator(.hidden)
        })
        .listStyle(.plain)
        .sheet(item: $selectedArticle, content: {
            if let url = $0.url {
                SafariView(url: url)
                    .edgesIgnoringSafeArea(.bottom)
            }
        })
    }
}

struct ArticleListView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleListView(articles: Article.stubItems)
    }
}
