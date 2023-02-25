//
//  PaletteManager.swift
//  Memorize
//
//  Created by Eduard on 21.02.2023.
//

import SwiftUI

struct PaletteManager: View {
    //    @ObservedObject var paletteStore: PaletteStore
    @Binding var palettes: [Palette]
    @State private var editMode: EditMode = .inactive
    @State private var isShowing = false
    @State private var isAdding = false
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
                            
                            Text(palette.emojis[0..<palette.numberPairsOfCardsToShow].joined(separator: ","))
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
                                .navigationBarTitle(palette.name)
                                .toolbar {
                                    ToolbarItem(placement: .navigationBarTrailing) {
                                        Button("Done") {
                                            palette.update(from: data)
                                            data = Palette.Data()
                                            isShowing = false
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
                        isAdding = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
            .environment(\.editMode, $editMode)
            .sheet(isPresented: $isAdding) {
                NavigationStack {
                    AddPalette(data: $data)
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationBarTitle(data.name)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                Button("Cancel") {
                                    data = Palette.Data()
                                    isAdding = false
                                    
                                }
                            }
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button("Done") {
                                    palettes.append(Palette(data: data))
                                    data = Palette.Data()
                                    isAdding = false
                                }
                            }
                        }
                }
            }
        }
    }
    
    var tap: some Gesture {
        TapGesture()
            .onEnded {_ in
                isShowing = true
            }
    }
}

struct PaletteManager_Previews: PreviewProvider {
    struct Preview: View {
        @StateObject var paletteStore = PaletteStore()
        
        var body: some View {
            PaletteManager(palettes: $paletteStore.palettes)
            //            PaletteManager(paletteStore: paletteStore)
        }
    }
    
    static var previews: some View {
        Preview()
    }
}
