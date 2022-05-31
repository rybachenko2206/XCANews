//
//  XCANewsApp.swift
//  XCANews
//
//  Created by Roman Rybachenko on 31.05.2022.
//

import SwiftUI

@main
struct XCANewsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
