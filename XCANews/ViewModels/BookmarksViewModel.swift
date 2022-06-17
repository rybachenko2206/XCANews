//
//  ArticleBookmarkViewModel.swift
//  XCANews
//
//  Created by Roman Rybachenko on 16.06.2022.
//

import Foundation

@MainActor
class BookmarksViewModel: ObservableObject {
    // TODO: maybe it should be just private
    @Published private(set) var bookmarks: [Article] = []
    
    func isBookmarkedArticle(_ article: Article) -> Bool {
        return bookmarks.contains(where: { $0.id == article.id })
    }
    
    func addBookmark(for article: Article) {
        // TODO: maybe change property "bookmarks" type to Set
        guard !isBookmarkedArticle(article) else { return }
        bookmarks.append(article)
    }
    
    func removeBookmark(for article: Article) {
        guard let index = bookmarks.firstIndex(where: { $0.id == article.id }) else { return }
        bookmarks.remove(at: index)
    }
}
