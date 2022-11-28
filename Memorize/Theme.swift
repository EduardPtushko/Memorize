//
//  Theme.swift
//  Memorize
//
//  Created by Eduard on 24.11.2022.
//

import Foundation
import SwiftUI

struct ThemeModel {
   private(set) var theme: Theme

    
}


struct Theme {
    let name: String
    var emojis: [String]
    let numberOfPairsOfCardsToShow: Int
    let color: Color
}

let themes = [
    Theme(name: "cars", emojis: ["🚗", "🛴", "✈️", "🛵", "⛵️", "🚎", "🚐", "🚛", "🛻", "🏎", "🚂", "🚊", "🚀", "🚁", "🚢", "🛶", "🛥", "🚞", "🚟", "🚃"], numberOfPairsOfCardsToShow: 10, color: .brown),
    Theme(
        name: "Halloween",
        emojis: ["👻","🎃","🕷","🧟‍♂️","🧛🏼‍♀️","☠️","👽","🦹‍♀️","🦇","🌘","⚰️","🔮"],
        numberOfPairsOfCardsToShow: 12, color: .orange
    ),
    Theme(
        name: "Flags",
        emojis: ["🇸🇬","🇯🇵","🏴‍☠️","🏳️‍🌈","🇬🇧","🇹🇼","🇺🇸","🇦🇶","🇰🇵","🇭🇰","🇲🇨","🇼🇸"],  numberOfPairsOfCardsToShow: 8,
        color: .red
     ),
    Theme(
        name: "Animals",
        emojis: ["🦑","🦧","🦃","🦚","🐫","🦉","🦕","🦥","🐸","🐼","🐺","🦈"], numberOfPairsOfCardsToShow: 6,
        color: .green),
    Theme(
        name: "Places",
        emojis: ["🗽","🗿","🗼","🎢","🌋","🏝","🏜","⛩","🕍","🕋","🏯","🏟"], numberOfPairsOfCardsToShow: 4,
        color: .blue),
    Theme(
        name: "Sports",
        emojis: ["🤺","🏑","⛷","⚽️","🏀","🪂","🥏","⛳️","🛹","🎣","🏉","🏓"], numberOfPairsOfCardsToShow: 8,
        color: .orange
       ),
    Theme(
        name: "Foods",
        emojis: ["🌮","🍕","🍝","🍱","🍪","🍩","🥨","🥖","🍟","🍙","🍢","🍿"], numberOfPairsOfCardsToShow: 7,
        color: .yellow)
]
