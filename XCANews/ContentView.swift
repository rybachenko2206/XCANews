//
//  ContentView.swift
//  XCANews
//
//  Created by Roman Rybachenko on 31.05.2022.
//

import SwiftUI

struct ContentView: View {


    var body: some View {
        ArticleListView(articles: Article.stubItems)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
