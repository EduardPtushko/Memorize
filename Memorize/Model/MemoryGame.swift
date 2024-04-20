//
//  MemoryGame.swift
//  Memorize
//
//  Created by Eduard Ptushko on 30.03.2024.
//

import Foundation

struct MemoryGame<CardContent: Equatable> {
    private(set) var cards: [Card]
    private(set) var score = 0

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
        }
    }

    mutating func choose(card: Card) {
        if let chosenCardIndex = cards.firstIndex(where: { card.id == $0.id }) {
            if !cards[chosenCardIndex].isFaceUp, !cards[chosenCardIndex].isMatched {
                if let oneAndOnlyChosenCardIndex {
                    if cards[chosenCardIndex].content == cards[oneAndOnlyChosenCardIndex].content {
                        cards[chosenCardIndex].isMatched = true
                        cards[oneAndOnlyChosenCardIndex].isMatched = true
                        score += 2 + cards[chosenCardIndex].bonus + cards[oneAndOnlyChosenCardIndex].bonus
                    } else {
                        if cards[chosenCardIndex].hasBeenSeen {
                            score -= 1
                        }

                        if cards[oneAndOnlyChosenCardIndex].hasBeenSeen {
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

        var isFaceUp = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
                if oldValue, !isFaceUp {
                    hasBeenSeen = true
                }
            }
        }

        var isMatched = false {
            didSet {
                if isMatched {
                    stopUsingBonusTime()
                }
            }
        }

        let content: CardContent
        var hasBeenSeen = false

        var id: String

        // MARK: - Bonus Time

        // call this when the card transitions to face up state
        private mutating func startUsingBonusTime() {
            if isFaceUp, !isMatched, bonusPercentRemaining > 0, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }

        // call this when the card goes back face down or gets matched
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            lastFaceUpDate = nil
        }

        // the bonus earned so far (one point for every second of the bonusTimeLimit that was not used)
        // this gets smaller and smaller the longer the card remains face up without being matched
        var bonus: Int {
            Int(bonusTimeLimit * bonusPercentRemaining)
        }

        // percentage of the bonus time remaining
        var bonusPercentRemaining: Double {
            bonusTimeLimit > 0 ? max(0, bonusTimeLimit - faceUpTime) / bonusTimeLimit : 0
        }

        // how long this card has ever been face up and unmatched during its lifetime
        // basically, pastFaceUpTime + time since lastFaceUpDate
        var faceUpTime: TimeInterval {
            if let lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }

        // can be zero which would mean "no bonus available" for matching this card quickly
        var bonusTimeLimit: TimeInterval = 6

        // the last time this card was turned face up
        var lastFaceUpDate: Date?

        // the accumulated time this card was face up in the past
        // (i.e. not including the current time it's been face up if it is currently so)
        var pastFaceUpTime: TimeInterval = 0
    }
}

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
