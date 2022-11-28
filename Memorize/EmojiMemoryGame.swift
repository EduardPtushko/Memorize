//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Eduard on 22.11.2022.
//

import Foundation
import SwiftUI

class EmojiMemoryGame: ObservableObject {
    var theme: Theme = ThemeModel(theme: themes[0]).theme
    
    static func createMemoryGame(emojis: [String]) -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 4 ){ pairIndex in
            emojis[pairIndex]
        }
    }
    
    @Published private var model: MemoryGame<String> = createMemoryGame(emojis: themes[0].emojis)
    @Published var score = 0
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // MARK: - Intent(s)
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func newGame() {
        self.theme = themes.randomElement()!
    }
    
}

