//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Eduard Ptushko on 29.03.2024.
//

import Foundation

@Observable
final class EmojiMemoryGame {
    private static let emojis = ["👻", "🎃", "🕷", "🧟‍♂️", "🧛🏼‍♀️", "☠️", "👽", "🦹‍♀️", "🦇", "🌘", "⚰️", "🔮"]

    private static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame(numberOfPairsOfCards: 8) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            } else {
                return "❌"
            }
        }
    }

    private var model = createMemoryGame()

    var cards: [MemoryGame<String>.Card] {
        model.cards
    }

    // MARK: - Intents

    func shuffle() {
        model.shuffle()
    }

    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
