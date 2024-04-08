//
//  Theme.swift
//  Memorize
//
//  Created by Eduard Ptushko on 01.04.2024.
//

import SwiftData
import SwiftUI
import UIKit

@Model
class Theme: Identifiable, Hashable {
    var id: String {
        name
    }

    var name: String
    var emojis: [String]
    var numberOfPairsOfCards: Int
    var color: RGBA
    var orderIndex: Int?

    init(name: String, emojis: [String], numberOfPairsOfCards: Int, color: RGBA, orderIndex: Int? = nil) {
        self.name = name
        self.emojis = emojis
        self.numberOfPairsOfCards = numberOfPairsOfCards
        self.color = color
        self.orderIndex = orderIndex
    }

    static let `default` = Theme(name: "", emojis: [], numberOfPairsOfCards: 2, color: RGBA(color: Color.white))
}

extension Theme {
    static let sampleData = [
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
    ]
}

extension [Theme] {
    func indexOfTheme(withId id: Theme.ID) -> Self.Index {
        guard let index = firstIndex(where: { $0.id == id }) else { fatalError("Index out of range") }
        return index
    }
}
