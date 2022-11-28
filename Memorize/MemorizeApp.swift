//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Eduard on 22.11.2022.
//

import SwiftUI

@main
struct MemorizeApp: App {
   private let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}
