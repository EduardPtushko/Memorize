//
//  SampleData.swift
//  Memorize
//
//  Created by Eduard Ptushko on 06.04.2024.
//

import Foundation
import SwiftData

@MainActor
class SampleData {
    static let shared = SampleData()
    static let animals = ["🦑", "🦧", "🦃", "🦚", "🐫", "🦉", "🦕", "🦥", "🐸", "🐼", "🐺", "🦈"]

    let modelContainer: ModelContainer

    private init() {
        let schema = Schema([Theme.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)

        do {
            modelContainer = try ModelContainer(for: schema, configurations: modelConfiguration)
            configureData()
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }

    var modelContext: ModelContext {
        modelContainer.mainContext
    }

    func configureData() {
        for theme in Theme.sampleData {
            modelContext.insert(theme)
        }
        do {
            try modelContext.save()
        } catch {
            fatalError("Couldn't save sample data")
        }
    }

    var theme: Theme {
        Theme.sampleData[0]
    }
}
