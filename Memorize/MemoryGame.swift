//
//  MemoryGame.swift
//  Memorize
//
//  Created by Eduard Ptushko on 30.03.2024.
//

import Foundation

struct MemoryGame<CardContent: Equatable> {
    private(set) var cards: [Card]
    var score = 0

    init(numberOfPairs: Int, getCardContent: (Int) -> CardContent) {
        cards = []

        for index in 0..<max(2, numberOfPairs) {
            let content = getCardContent(index)
            cards.append(Card(content: content, id: "\(index)a"))
            cards.append(Card(content: content, id: "\(index)b"))
        }
        cards.shuffle()
    }

    var oneAndOnlyChosenCardIndex: Int? {
        get { cards.indices.filter { cards[$0].isFaceUp }.only }
        set {
            cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0) }
            if let newValue {
                cards[newValue].isSeen = true
            }
        }
    }

    mutating func choose(card: Card) {
        if let chosenCardIndex = cards.firstIndex(where: { card.id == $0.id }) {
            if !cards[chosenCardIndex].isFaceUp, !cards[chosenCardIndex].isMatched {
                if let oneAndOnlyChosenCardIndex {
                    if cards[chosenCardIndex].content == cards[oneAndOnlyChosenCardIndex].content {
                        cards[chosenCardIndex].isMatched = true
                        cards[oneAndOnlyChosenCardIndex].isMatched = true
                        score += 2
                    } else {
                        if card.isSeen {
                            score -= 1
                        }
                    }
                } else {
                    oneAndOnlyChosenCardIndex = chosenCardIndex
                }
                cards[chosenCardIndex].isFaceUp = true
            }
        }
    }

    mutating func shuffle() {
        cards.shuffle()
    }

    struct Card: Identifiable, CustomStringConvertible, Equatable {
        var description: String {
            "\(id): \(content) - \(isMatched) \(isFaceUp ? "up" : "")"
        }

        var isFaceUp = false
        var isMatched = false
        let content: CardContent
        var isSeen = false

        var id: String
    }
}

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
