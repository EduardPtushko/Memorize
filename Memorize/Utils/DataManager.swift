//
//  DataManager.swift
//  Memorize
//
//  Created by Eduard Ptushko on 07.04.2024.
//

import SwiftData
import SwiftUI

class DataManager {
    static let shared = DataManager()

    var modelContainer: ModelContainer

    private init() {
        let schema = Schema([
            Theme.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }

    static let themes = [
        Theme(
            name: "animals",
            emojis: ["🦑", "🦧", "🦃", "🦚", "🐫", "🦉", "🦕", "🦥", "🐸", "🐼", "🐺", "🦈"],
            numberOfPairsOfCards: 2,
            color: RGBA(color: Color.red)
        ),
        Theme(
            name: "flags",
            emojis: ["🇸🇬", "🇯🇵", "🏴‍☠️", "🏳️‍🌈", "🇬🇧", "🇹🇼", "🇺🇸", "🇦🇶", "🇰🇵", "🇭🇰", "🇲🇨", "🇼🇸"],
            numberOfPairsOfCards: 6,
            color: RGBA(color: Color.brown)
        ),
        Theme(
            name: "halloween",
            emojis: ["👻", "🎃", "🕷", "🧟‍♂️", "🧛🏼‍♀️", "☠️", "👽", "🦹‍♀️", "🦇", "🌘", "⚰️", "🔮"],
            numberOfPairsOfCards: 8,
            color: RGBA(color: Color.green)
        ),
        Theme(
            name: "food",
            emojis: ["🌮", "🍕", "🍝", "🍱", "🍪", "🍩", "🥨", "🥖", "🍟", "🍙", "🍢", "🍿"],
            numberOfPairsOfCards: 8,
            color: RGBA(color: Color.yellow)
        ),
        Theme(
            name: "places",
            emojis: ["🗽", "🗿", "🗼", "🎢", "🌋", "🏝", "🏜", "⛩", "🕍", "🕋", "🏯", "🏟"],
            numberOfPairsOfCards: 8,
            color: RGBA(color: Color.cyan)
        ),
        Theme(
            name: "sport",
            emojis: ["🤺", "🏑", "⛷", "⚽️", "🏀", "🪂", "🥏", "⛳️", "🛹", "🎣", "🏉", "🏓"],
            numberOfPairsOfCards: 8,
            color: RGBA(color: Color.orange)
        ),
        Theme(
            name: "vehicles",
            emojis: ["🚗", "🛴", "✈️", "🛵", "⛵️", "🚎", "🚐", "🚛", "🛻", "🏎", "🚂", "🚊", "🚀", "🚁", "🚢", "🛶", "🛥", "🚞", "🚟", "🚃"],
            numberOfPairsOfCards: 6,
            color: RGBA(color: Color.black)
        ),
    ]

    @MainActor
    static func insertThemes(modelContext: ModelContext) {
        do {
            var itemFetchDescriptor = FetchDescriptor<Theme>()
            itemFetchDescriptor.fetchLimit = 1
            guard try modelContext.fetch(itemFetchDescriptor).isEmpty else { return }

            for theme in themes {
                modelContext.insert(theme)
            }

            try modelContext.save()
        } catch {
            fatalError("Could not save themes: \(error)")
        }
    }
}
