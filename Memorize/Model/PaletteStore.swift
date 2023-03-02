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
             ),
            Palette(
                name: "Animals",
                emojis: ["🦑","🦧","🦃","🦚","🐫","🦉","🦕","🦥","🐸","🐼","🐺","🦈"], numberPairsOfCardsToShow: 6,
                rgbaColor: RGBAColor(color: Color.green)),
            Palette(
                name: "Places",
                emojis: ["🗽","🗿","🗼","🎢","🌋","🏝","🏜","⛩","🕍","🕋","🏯","🏟"], numberPairsOfCardsToShow: 4,
                rgbaColor: RGBAColor(color: Color.blue)),
            Palette(
                name: "Sports",
                emojis: ["🤺","🏑","⛷","⚽️","🏀","🪂","🥏","⛳️","🛹","🎣","🏉","🏓"], numberPairsOfCardsToShow: 8,
                rgbaColor: RGBAColor(color: Color.gray)
               ),
            Palette(
                name: "Foods",
                emojis: ["🌮","🍕","🍝","🍱","🍪","🍩","🥨","🥖","🍟","🍙","🍢","🍿"], numberPairsOfCardsToShow: 7,
                rgbaColor: RGBAColor(color: Color.yellow))
        ]
    }
}


