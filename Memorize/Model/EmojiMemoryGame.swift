//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Eduard on 22.11.2022.
//

import Foundation
import SwiftUI

class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    
    var palette: Palette
    @Published private var model: MemoryGame<String>
    
    init(palette: Palette) {
        self.palette = palette
        self.model = EmojiMemoryGame.createMemoryGame(palette: palette)
    }
    
    static func createMemoryGame(palette: Palette) -> MemoryGame<String> {
        var emojis = Array(Set(palette.emojis))
        var numberOfPairs = palette.numberPairsOfCardsToShow
        
        if numberOfPairs > emojis.count {
            numberOfPairs = palette.emojis.count
        }
        
        if numberOfPairs < emojis.count {
            emojis.shuffle()
        }
        
       return MemoryGame<String>(numberOfPairsOfCards: numberOfPairs ){ pairIndex in
           emojis[pairIndex]
        }
    }
    
    
    var cards: Array<Card> {
        return model.cards
    }
    
  
    // MARK: - Intent(s)
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    func newGame() {
        model = EmojiMemoryGame.createMemoryGame(palette: self.palette)
    }
    
}

