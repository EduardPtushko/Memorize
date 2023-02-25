//
//  Palette.swift
//  Memorize
//
//  Created by Eduard on 22.02.2023.
//

import Foundation
import SwiftUI

struct Palette: Identifiable {
    let id: UUID
    var name: String
    var emojis: [String]
    var numberPairsOfCardsToShow: Int
    var color: Color
    
    init(id: UUID = UUID(), name: String, emojis: [String], numberPairsOfCardsToShow: Int, color: Color) {
        self.id = id
        self.name = name
        self.emojis = emojis
        self.numberPairsOfCardsToShow = numberPairsOfCardsToShow
        self.color = color
    }
}

extension Palette {
    struct Data {
        var name: String = ""
        var emojis: [String] = []
        var numberPairsOfCardsToShow: Int = 0
        var color: Color = .brown
      }
      
      var data: Data {
          Data(name: self.name, emojis: emojis, numberPairsOfCardsToShow: numberPairsOfCardsToShow, color: color)
      }

      mutating func update(from data: Data) {
          self.name = data.name
          self.emojis = data.emojis
          self.numberPairsOfCardsToShow = data.numberPairsOfCardsToShow
          self.color = data.color
      }

      init(data: Data) {
          id = UUID()
          name = data.name
          emojis = data.emojis
          numberPairsOfCardsToShow = data.numberPairsOfCardsToShow
          color = data.color
      }
}

extension Palette {
    static var sampleData: [Palette] = [
        Palette(name: "Cars", emojis: ["🚗", "🛴", "✈️", "🛵", "⛵️", "🚎", "🚐", "🚛", "🛻", "🏎", "🚂", "🚊", "🚀", "🚁", "🚢", "🛶", "🛥", "🚞", "🚟", "🚃"], numberPairsOfCardsToShow: 10, color: .brown),
        Palette(
            name: "Halloween",
            emojis: ["👻","🎃","🕷","🧟‍♂️","🧛🏼‍♀️","☠️","👽","🦹‍♀️","🦇","🌘","⚰️","🔮"],
            numberPairsOfCardsToShow: 12, color: .orange
        ),
        Palette(
            name: "Flags",
            emojis: ["🇸🇬","🇯🇵","🏴‍☠️","🏳️‍🌈","🇬🇧","🇹🇼","🇺🇸","🇦🇶","🇰🇵","🇭🇰","🇲🇨","🇼🇸"],  numberPairsOfCardsToShow: 8,
            color: .red
         )
    ]
}
