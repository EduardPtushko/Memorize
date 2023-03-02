//
//  PaletteStore.swift
//  Memorize
//
//  Created by Eduard on 21.02.2023.
//

import Foundation
import SwiftUI

final class PaletteStore: ObservableObject {
    let name: String
    @Published var palettes: [Palette] = [] {
        didSet {
            saveToUserDefaults()
        }
    }
    
    private  var userDefaultsKey: String {
        "PaletteStore: " + name
    }
    
    private func saveToUserDefaults() {
        UserDefaults.standard.set(try? JSONEncoder().encode(palettes), forKey: userDefaultsKey)
    }
    
    private func restoreFromUserDefaults() {
        if let jsonData =   UserDefaults.standard.data(forKey: userDefaultsKey),
           let decodedPalettes = try? JSONDecoder().decode([Palette].self, from: jsonData) {
            palettes = decodedPalettes
        }
    }
    
    init(named name: String) {
        self.name = name
        restoreFromUserDefaults()
        if palettes.isEmpty {
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
}


