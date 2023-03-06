//
//  PaletteManager.swift
//  Memorize
//
//  Created by Eduard on 21.02.2023.
//

import SwiftUI

struct PaletteManager: View {
    @Binding var palettes: [Palette]
    @State private var editMode: EditMode = .inactive
    @State private var isShowing = false
    @State private var isAddingPalette = false
    @State private var data = Palette.Data()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach($palettes) { $palette in
                    NavigationLink{
                        EmojiMemoryGameView(game: EmojiMemoryGame(palette: palette))
                    } label:{
                        VStack(alignment: .leading, spacing: 8) {
                            Text(palette.name)
                                .font(.title2)
                                .foregroundColor(palette.color)
                            Text(palette.emojis[0..<palette.numberPairsOfCardsToShow].joined(separator: ""))
                                .lineLimit(1)
                        }
                    }
                    .gesture(editMode == .active ?  TapGesture()
                        .onEnded {_ in
                            data = palette.data
                            isShowing = true
                        } : nil)
                    .sheet(isPresented: $isShowing) {
                        NavigationStack {
                            PaletteEditor(data: $data)
                                .navigationBarTitleDisplayMode(.inline)
                                .navigationTitle(data.name)
                                .toolbar {
                                    ToolbarItem(placement: .navigationBarTrailing) {
                                        Button("Done") {
                                            if  let index = palettes.firstIndex(where: { $0.id == data.id}) {
                                                palettes[index].update(from: data)
                                            }
                                            isShowing = false
                                            data = Palette.Data()
                                        }
                                    }
                                }
                        }
                        
                    }
                }
                .onDelete{ indexSet in
                    palettes.remove(atOffsets: indexSet)
                }
            }
            .navigationTitle("Memorize")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        isAddingPalette = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
            .environment(\.editMode, $editMode)
            .sheet(isPresented: $isAddingPalette) {
                NavigationStack {
                    PaletteEditor(data: $data)
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationTitle(data.name)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                Button("Cancel") {
                                    isAddingPalette = false
                                    data = Palette.Data()
                                }
                            }
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button("Done") {
                                    palettes.append(Palette(data: data))
                                    isAddingPalette = false
                                    data = Palette.Data()
                                }
                            }
                        }
                }
            }
        }
    }
    
}

struct PaletteManager_Previews: PreviewProvider {
    struct Preview: View {
        @StateObject var paletteStore = PaletteStore(named: "Preview")
        
        var body: some View {
            PaletteManager(palettes: $paletteStore.palettes)
        }
    }
    
    static var previews: some View {
        Preview()
    }
}


