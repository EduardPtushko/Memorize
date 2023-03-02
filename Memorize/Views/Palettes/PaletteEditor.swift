//
//  PaletteEditor.swift
//  Memorize
//
//  Created by Eduard on 21.02.2023.
//

import SwiftUI

struct PaletteEditor: View {
    @Binding var data: Palette.Data
    @State private var emoji = ""
    
    var body: some View {
        Form {
            paletteNameSection
            emojisSection
            addEmojiSection
            cardCountSection
            chooseColorSection
        }
    }
}

extension PaletteEditor {
    var paletteNameSection: some View {
        Section {
            TextField("Palette name", text: $data.name)
        } header: {
            Text("Palette Name".uppercased())
                .fontWeight(.bold)
        }
    }
    
    var emojisSection: some View {
        Section {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 34))],spacing: 4) {
                ForEach(data.emojis, id: \.self) { emoji in
                    Text("\(emoji)")
                        .font(.largeTitle)
                        .onTapGesture {
                            let index = data.emojis.firstIndex(where: { $0 == emoji})
                            if let index {
                                data.emojis.remove(at: index)
                            }
                        }
                }
            }
        } header: {
            HStack{
                Text("Emojis".uppercased())
                    .fontWeight(.bold)
                Spacer()
                Text("Tap emojis to exclude".uppercased())
            }
        }
    }
    
    var addEmojiSection: some View {
        Section {
            TextField("Emoji", text: $emoji)
                .keyboardType(.default)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .onChange(of: emoji, perform: { newValue in
                    if newValue.containsOnlyEmoji {
                        emoji = newValue
                    } else {
                        emoji = newValue.compactMap({ str in
                            str.isEmoji ? String(str) : ""
                        }).joined()
                    }
                })
                .onSubmit {
                    data.emojis = Array(Set(data.emojis + emoji.split(separator: "").map { String($0)}))
                    emoji = ""
                }
            
        } header: {
            Text("Add Emoji".uppercased())
                .fontWeight(.bold)
        }
    }
    
    var cardCountSection: some View {
        Section {
            Stepper("\(data.numberPairsOfCardsToShow)", value: $data.numberPairsOfCardsToShow, in: 0...data.emojis.count, step: 1)
                .onChange(of: data.emojis) { value in
                    if data.numberPairsOfCardsToShow > value.count {
                        data.numberPairsOfCardsToShow = value.count
                    }
                }
            
        } header: {
            Text("Card count".uppercased())
                .fontWeight(.bold)
        }
    }
    
    var chooseColorSection: some View {
        Section {
            ChooseColorView(data: $data)
        } header: {
            Text("Choose Color".uppercased())
                .fontWeight(.bold)
        }
    }
}


struct PaletteEditor_Previews: PreviewProvider {
    struct Preview: View {
        @State  private var data = Palette.sampleData[0].data
        
        var body: some View {
            PaletteEditor(data: $data)
        }
    }
    
    static var previews: some View {
        Preview()
    }
}

