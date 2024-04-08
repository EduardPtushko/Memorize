//
//  String+Memorize.swift
//  Memorize
//
//  Created by Eduard Ptushko on 08.04.2024.
//

import Foundation

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
