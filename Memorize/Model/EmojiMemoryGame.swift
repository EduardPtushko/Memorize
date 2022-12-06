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
    
    @Published  var themeModel: ThemeModel
    @Published private var model: MemoryGame<String>
    @Published var score = 0
    var seenCards: [Card] = []
    
    static func createMemoryGame(theme: ThemeModel.Theme) -> MemoryGame<String> {
        var emojis = Array(Set(theme.emojis))
        var numberOfPairs = theme.numberOfPairsOfCardsToShow
        
        if theme.numberOfPairsOfCardsToShow > emojis.count {
            numberOfPairs = theme.emojis.count
        }
        
        if theme.numberOfPairsOfCardsToShow < emojis.count {
            emojis.shuffle()
        }
        
       return  MemoryGame<String>(numberOfPairsOfCards: numberOfPairs ){ pairIndex in
           emojis[pairIndex]
        }
    }
    
    init(themeModel: ThemeModel) {
        self.themeModel = themeModel
        self.model = EmojiMemoryGame.createMemoryGame(theme: themeModel.theme)
    }
    
    
    var theme: ThemeModel.Theme {
        themeModel.theme
    }
    
    var cards: Array<Card> {
        return model.cards
    }
    
    func handleScore(_ card: Card) {
        if seenCards.contains(where: {card.id == $0.id}) {
            score -= 1
        } else {
            score += 2
        }
    }
    
    // MARK: - Intent(s)
    func choose(_ card: Card) {
        model.choose(card)
        seenCards.append(card)
    }
    
    func newGame() {
        themeModel.newGame()
        model = EmojiMemoryGame.createMemoryGame(theme: themeModel.theme)
    }
    
}

