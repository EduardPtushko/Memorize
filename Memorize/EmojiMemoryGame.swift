//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Eduard Ptushko on 30.03.2024.
//

import SwiftUI

@Observable
final class EmojiMemoryGame {
    typealias Card = MemoryGame<String>.Card

    static func createMemoryGame(theme: ThemeModel.Theme) -> MemoryGame<String> {
        MemoryGame(numberOfPairs: theme.numberOfPairsOfCards) { index in
            theme.emojis[index]
        }
    }

//    private var themeModel: ThemeModel
    private var model: MemoryGame<String>
    var theme: ThemeModel.Theme

    init(theme: ThemeModel.Theme) {
        self.theme = theme
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }

    var cards: [Card] {
        model.cards
    }

    var score: Int {
        model.score
    }

    var color: Color {
        theme.color
    }

    // MARK: - Intents

    func choose(card: Card) {
        model.choose(card: card)
    }

    func shuffle() {
        model.shuffle()
    }

    func newGame() {
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }
}
