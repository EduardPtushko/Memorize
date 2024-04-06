//
//  ThemeModel.swift
//  Memorize
//
//  Created by Eduard Ptushko on 01.04.2024.
//

import SwiftUI
import UIKit

struct ThemeModel {
    var themes: [Theme]
    var currentTheme: Theme

    init(themes: [Theme]) {
        self.themes = themes
        currentTheme = self.themes.shuffled()[0]
    }

    mutating func newGame() {
        currentTheme.emojis.shuffle()
    }

    mutating func addTheme(theme: Theme) {
        themes.append(theme)
    }

    mutating func setNewCurrent(theme: Theme) {
        currentTheme = theme
    }

    struct Theme: Identifiable, Hashable {
        var id: String {
            name
        }

        var name: String
        var emojis: [String]
        var numberOfPairsOfCards: Int
        let color: Color

        static let sampleTheme = Theme(name: "flags", emojis: SampleData.flags, numberOfPairsOfCards: 6, color: Color.brown)
        static let `default` = Theme(name: "", emojis: [], numberOfPairsOfCards: 2, color: Color.white)
    }
}

extension [ThemeModel.Theme] {
    func indexOfTheme(withId id: ThemeModel.Theme.ID) -> Self.Index {
        guard let index = firstIndex(where: { $0.id == id }) else { fatalError("Index out of range") }
        return index
    }
}

extension Character {
    var isSimpleEmoji: Bool {
        unicodeScalars.count == 1 && unicodeScalars.first?.properties.isEmojiPresentation ?? false
    }

    var isCombinedIntoEmoji: Bool {
        unicodeScalars.count > 1 &&
            unicodeScalars.contains { $0.properties.isJoinControl || $0.properties.isVariationSelector }
    }

    var isEmoji: Bool {
        isSimpleEmoji || isCombinedIntoEmoji
    }
}

extension String {
    var isSingleEmoji: Bool {
        count == 1 && containsEmoji
    }

    var containsEmoji: Bool {
        contains { $0.isEmoji }
    }

    var containsOnlyEmoji: Bool {
        !isEmpty && !contains { !$0.isEmoji }
    }

    var emojiString: String {
        emojis.map { String($0) }.reduce("", +)
    }

    var emojis: [Character] {
        filter(\.isEmoji)
    }

    var emojiScalars: [UnicodeScalar] {
        filter(\.isEmoji).flatMap(\.unicodeScalars)
    }
}

extension String {
    var removingDuplicateCharacters: String {
        reduce(into: "") { sofar, element in
            if !sofar.contains(element) {
                sofar.append(element)
            }
        }
    }
}
