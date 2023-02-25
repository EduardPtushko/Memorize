//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Eduard on 22.11.2022.
//

import SwiftUI

@main
struct MemorizeApp: App {
    @StateObject var paletteStore = PaletteStore()
    
    var body: some Scene {
        WindowGroup {
            PaletteManager(palettes: $paletteStore.palettes)
        }
    }
}
