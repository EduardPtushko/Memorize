//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Eduard Ptushko on 29.03.2024.
//

import SwiftData
import SwiftUI

@main
struct MemorizeApp: App {
    var sharedModelContainer: ModelContainer {
        DataManager.shared.modelContainer
    }

    var body: some Scene {
        WindowGroup {
            RootView()
                .modelContainer(sharedModelContainer)
                .task {
                    DataManager.insertThemes(modelContext: sharedModelContainer.mainContext)
                }
        }
    }
}
