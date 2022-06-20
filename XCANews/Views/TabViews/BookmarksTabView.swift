//
//  BookmarksTabView.swift
//  XCANews
//
//  Created by Roman Rybachenko on 20.06.2022.
//

import SwiftUI

struct BookmarksTabView: View {
    
    @EnvironmentObject var bookmarksVM: BookmarksViewModel
    
    var body: some View {
        NavigationView(content: {
            ArticleListView(articles: bookmarksVM.bookmarks)
                .overlay(content: { overlayView })
                .navigationTitle("Saved Articles")
        })
    }
    
    @ViewBuilder
    var overlayView: some View {
        if bookmarksVM.bookmarks.isEmpty {
            EmptyListView(text: "No saved articles", image: Image(systemName: "bookmark"))
        } else {
            EmptyView()
        }
    }
}

struct BookmarksTabView_Previews: PreviewProvider {
    @StateObject static private var bookmarksVM = BookmarksViewModel()
    
    static var previews: some View {
        BookmarksTabView()
            .environmentObject(bookmarksVM)
    }
}
