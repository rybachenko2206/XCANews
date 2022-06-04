//
//  ArticleListView.swift
//  XCANews
//
//  Created by Roman Rybachenko on 04.06.2022.
//

import SwiftUI

struct ArticleListView: View {
    let articles: [Article]
    
    var body: some View {
        List(content: {
            ForEach(articles, content: { article in
                ArticleRowView(article: article)
            })
        })
        .listStyle(.plain)
    }
}

struct ArticleListView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleListView(articles: Article.stubItems)
    }
}
