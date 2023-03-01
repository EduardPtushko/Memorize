//
//  PaletteStore.swift
//  Memorize
//
//  Created by Eduard on 21.02.2023.
//

import Foundation
import SwiftUI


final class PaletteStore: ObservableObject {
    @Published var palettes: [Palette] = []
    
    init() {
        palettes =  [
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
             ),
            Palette(
                name: "Animals",
                emojis: ["🦑","🦧","🦃","🦚","🐫","🦉","🦕","🦥","🐸","🐼","🐺","🦈"], numberPairsOfCardsToShow: 6,
                color: .green),
            Palette(
                name: "Places",
                emojis: ["🗽","🗿","🗼","🎢","🌋","🏝","🏜","⛩","🕍","🕋","🏯","🏟"], numberPairsOfCardsToShow: 4,
                color: .blue),
            Palette(
                name: "Sports",
                emojis: ["🤺","🏑","⛷","⚽️","🏀","🪂","🥏","⛳️","🛹","🎣","🏉","🏓"], numberPairsOfCardsToShow: 8,
                color: .orange
               ),
            Palette(
                name: "Foods",
                emojis: ["🌮","🍕","🍝","🍱","🍪","🍩","🥨","🥖","🍟","🍙","🍢","🍿"], numberPairsOfCardsToShow: 7,
                color: .yellow)
        ]
    }
}


