//
//  XCANewsApp.swift
//  XCANews
//
//  Created by Roman Rybachenko on 31.05.2022.
//

import SwiftUI

@main
struct XCANewsApp: App {
    
    @StateObject var bookmarkVM = BookmarksViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView(newsViewModel: NewsViewModel(networkService: NetworkService()))
                .environmentObject(bookmarkVM)
        }
    }
}
