//
//  Palette.swift
//  Memorize
//
//  Created by Eduard on 22.02.2023.
//

import Foundation
import SwiftUI

struct Palette: Codable, Identifiable {
    let id: UUID
    var name: String
    var emojis: [String]
    var numberPairsOfCardsToShow: Int
    var rgbaColor: RGBAColor
    
    init(id: UUID = UUID(), name: String, emojis: [String], numberPairsOfCardsToShow: Int, rgbaColor: RGBAColor) {
        self.id = id
        self.name = name
        self.emojis = emojis
        self.numberPairsOfCardsToShow = numberPairsOfCardsToShow
        self.rgbaColor = rgbaColor
    }
}

extension Palette {
    struct Data: Codable, Identifiable {
        var id = UUID()
        var name: String = ""
        var emojis: [String] = []
        var numberPairsOfCardsToShow: Int = 0
        var rgbaColor: RGBAColor = RGBAColor(color: .brown)
      }
      
      var data: Data {
          Data(id: self.id, name: self.name, emojis: emojis, numberPairsOfCardsToShow: numberPairsOfCardsToShow, rgbaColor: rgbaColor)
      }

      mutating func update(from data: Data) {
          self.name = data.name
          self.emojis = data.emojis
          self.numberPairsOfCardsToShow = data.numberPairsOfCardsToShow
          self.rgbaColor = data.rgbaColor
      }

      init(data: Data) {
          id = UUID()
          name = data.name
          emojis = data.emojis
          numberPairsOfCardsToShow = data.numberPairsOfCardsToShow
          rgbaColor = data.rgbaColor
      }
}


extension Palette {
    static var sampleData: [Palette] = [
        Palette(name: "Cars", emojis: ["🚗", "🛴", "✈️", "🛵", "⛵️", "🚎", "🚐", "🚛", "🛻", "🏎", "🚂", "🚊", "🚀", "🚁", "🚢", "🛶", "🛥", "🚞", "🚟", "🚃"], numberPairsOfCardsToShow: 10, rgbaColor: RGBAColor(color: Color.brown)),
        Palette(
            name: "Halloween",
            emojis: ["👻","🎃","🕷","🧟‍♂️","🧛🏼‍♀️","☠️","👽","🦹‍♀️","🦇","🌘","⚰️","🔮"],
            numberPairsOfCardsToShow: 12, rgbaColor: RGBAColor(color: Color.orange)
        ),
        Palette(
            name: "Flags",
            emojis: ["🇸🇬","🇯🇵","🏴‍☠️","🏳️‍🌈","🇬🇧","🇹🇼","🇺🇸","🇦🇶","🇰🇵","🇭🇰","🇲🇨","🇼🇸"],  numberPairsOfCardsToShow: 8,
            rgbaColor: RGBAColor(color: Color.red)
         )
    ]
}
