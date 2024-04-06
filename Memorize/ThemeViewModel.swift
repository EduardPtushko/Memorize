//
//  ThemeViewModel.swift
//  Memorize
//
//  Created by Eduard Ptushko on 05.04.2024.
//

import SwiftUI

@Observable
final class ThemeViewModel {
    typealias Theme = ThemeModel.Theme
    var themes: [Theme] = []
    var colors: [Color] = []

    init() {
        themes = [
            Theme(name: "animals", emojis: ["🦑", "🦧", "🦃", "🦚", "🐫", "🦉", "🦕", "🦥", "🐸", "🐼", "🐺", "🦈"], numberOfPairsOfCards: 2, color: Color.red),
            Theme(name: "flags", emojis: ["🇸🇬", "🇯🇵", "🏴‍☠️", "🏳️‍🌈", "🇬🇧", "🇹🇼", "🇺🇸", "🇦🇶", "🇰🇵", "🇭🇰", "🇲🇨", "🇼🇸"], numberOfPairsOfCards: 6, color: Color.brown),
            Theme(name: "halloween", emojis: ["👻", "🎃", "🕷", "🧟‍♂️", "🧛🏼‍♀️", "☠️", "👽", "🦹‍♀️", "🦇", "🌘", "⚰️", "🔮"], numberOfPairsOfCards: 8, color: Color.green),
            Theme(name: "food", emojis: ["🌮", "🍕", "🍝", "🍱", "🍪", "🍩", "🥨", "🥖", "🍟", "🍙", "🍢", "🍿"], numberOfPairsOfCards: 8, color: Color.yellow),
            Theme(name: "places", emojis: ["🗽", "🗿", "🗼", "🎢", "🌋", "🏝", "🏜", "⛩", "🕍", "🕋", "🏯", "🏟"], numberOfPairsOfCards: 8, color: Color.cyan),
            Theme(name: "sport", emojis: ["🤺", "🏑", "⛷", "⚽️", "🏀", "🪂", "🥏", "⛳️", "🛹", "🎣", "🏉", "🏓"], numberOfPairsOfCards: 8, color: Color.orange),
            Theme(
                name: "vehicles",
                emojis: ["🚗", "🛴", "✈️", "🛵", "⛵️", "🚎", "🚐", "🚛", "🛻", "🏎", "🚂", "🚊", "🚀", "🚁", "🚢", "🛶", "🛥", "🚞", "🚟", "🚃"],
                numberOfPairsOfCards: 6,
                color: Color.black
            ),
        ]

        colors = [
            Color.red,
            Color.blue,
            Color.black,
            Color.green,
            Color.gray,
            Color.brown,
            Color.cyan,
            Color.indigo,
            Color.mint,
            Color.orange,
            Color.pink,
        ]
    }

    func theme(with id: Theme.ID) -> Theme {
        let index = themes.indexOfTheme(withId: id)
        return themes[index]
    }

    func updateTheme(_ theme: Theme) {
        let index = themes.indexOfTheme(withId: theme.id)
        themes[index] = theme
    }

    func addTheme(_ theme: Theme) {
        themes.append(theme)
    }

    func deleteTheme(_ theme: Theme) {
        let index = themes.indexOfTheme(withId: theme.id)
        themes.remove(at: index)
    }
}
