//
//  AddPalette.swift
//  Memorize
//
//  Created by Eduard on 22.02.2023.
//

import SwiftUI

struct AddPalette: View {
    @Binding var data: Palette.Data
    @State private var emoji = ""

    let columnLayout = Array(repeating: GridItem(.adaptive(minimum: 44)), count: 1)
    let allColors: [Color] = [
        .pink,
        .red,
        .orange,
        .yellow,
        .green,
        .mint,
        .teal,
        .cyan,
        .blue,
        .indigo,
        .purple,
        .brown,
        .gray
    ]
    
    var body: some View {
        Form {
            Section {
                TextField("Palette name", text: $data.name)
                    
            } header: {
                Text("Palette Name".uppercased())
                    .fontWeight(.bold)
            }
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
            Section {
                LazyVGrid(columns: columnLayout) {
                    ForEach(allColors.indices, id: \.self) { index in
                        RoundedRectangle(cornerRadius: 8)
                            .aspectRatio(2/3, contentMode: .fit)
                            .foregroundColor(allColors[index])
                            .onTapGesture {
                                data.color = allColors[index]
                            }
                    }
                    
                    ColorPicker("", selection: $data.color)
                        .scaleEffect(1.7)
                        .labelsHidden()
                }
            } header: {
                Text("Color".uppercased())
                    .fontWeight(.bold)
            }
        }
    }
}

struct AddPalette_Previews: PreviewProvider {
    struct Preview: View {
        @State private var data = Palette.Data()
        
        var body: some View {
            AddPalette(data: $data)
        }
    }
    
    static var previews: some View {
        Preview()
    }
}
