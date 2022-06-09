//
//  NewsViewModel.swift
//  XCANews
//
//  Created by Roman Rybachenko on 07.06.2022.
//

import Foundation

enum FetchDataState<T> {
    case loading
    case success(T)
    case failure(AppError)
}

@MainActor
class NewsViewModel: ObservableObject {
    // MARK: - Properties
    @Published var selectedCategory: Category
    @Published var state: FetchDataState<[Article]>
    
    private let networkService: PNetworkService
    
    // MARK: - Init
    init(selectedCategory: Category = .general, articles: [Article]? = nil, networkService: PNetworkService) {
        self.selectedCategory = selectedCategory
        self.networkService = networkService
        
        if let articles = articles {
            state = .success(articles)
        } else {
            state = .loading
        }
    }
    
    // MARK: - Public funcs
    func loadArticles() async {
        state = .loading
        do {
            let articles = try await networkService.getNews(for: selectedCategory)
            state = .success(articles)
        } catch {
            state = .failure(error as? AppError ?? .defaultError)
        }
    }
}
