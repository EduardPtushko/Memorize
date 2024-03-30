//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Eduard Ptushko on 29.03.2024.
//

import SwiftUI

@main
struct MemorizeApp: App {
    var game = EmojiMemoryGame()

    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
