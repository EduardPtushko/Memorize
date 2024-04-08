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

    static func createMemoryGame(theme: Theme) -> MemoryGame<String> {
        MemoryGame(numberOfPairs: theme.numberOfPairsOfCards) { index in
            theme.emojis[index]
        }
    }

    private var model: MemoryGame<String>
    var theme: Theme

    init(theme: Theme) {
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
        Color(rgba: theme.color)
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
