//
//  ThemeDetailsView.swift
//  Memorize
//
//  Created by Eduard Ptushko on 06.04.2024.
//

import SwiftUI

struct ThemeDetailsView: View {
    let theme: ThemeModel.Theme
    @State private var name = ""
    @State private var emoji = ""
    @State private var emojis: [String] = []
    @State private var numberOfPairs = 0
    @State private var selectedColor: Color = .red

    @Environment(\.dismiss)
    var dismiss

    @Environment(ThemeViewModel.self) private var themeViewModel

    let isNew: Bool

    init(theme: ThemeModel.Theme, isNew: Bool = false) {
        self.theme = theme
        self.isNew = isNew
    }

    var body: some View {
        Form {
            Section {
                TextField("", text: $name)
            } header: {
                Text("Theme Name")
                    .font(.headline)
            }

            Section {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 44), spacing: 4)], spacing: 4) {
                    ForEach(emojis, id: \.self) { emoji in
                        Button {} label: {
                            Text(emoji)
                                .font(.largeTitle)
                        }
                    }
                }
            } header: {
                HStack {
                    Text("Emojis")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Tap emoji to exclude")
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
                            emoji = newValue.compactMap { str in
                                str.isEmoji ? String(str) : ""
                            }.joined()
                        }
                    })
                    .onSubmit {
//                        data.emojis = Array(Set(data.emojis + emoji.split(separator: "").map { String($0)}))
                        emoji = ""
                    }
            } header: {
                HStack {
                    Text("Add Emoji")
                        .font(.headline)
                }
            }
            Section {
                Stepper("\(numberOfPairs) Pairs", value: $numberOfPairs, in: 0...(emojis.count / 2))
            } header: {
                HStack {
                    Text("Card Count")
                        .font(.headline)
                }
            }
            Section {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 44), spacing: 4)], spacing: 8) {
                    ForEach(
                        themeViewModel.colors,
                        id: \.self
                    ) { color in
                        ColorToSelectView(color: color, isSelected: color == selectedColor)
                            .onTapGesture {
                                withAnimation {
                                    selectedColor = color
                                }
                            }
                    }
                }
            } header: {
                HStack {
                    Text("Color")
                        .font(.headline)
                }
            }
        }
        .navigationTitle(theme.name.capitalized)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button {
                    dismiss()
                } label: {
                    Text("Cancel")
                }
            }
            ToolbarItem(placement: .confirmationAction) {
                let theme = ThemeModel.Theme(name: name, emojis: emojis, numberOfPairsOfCards: numberOfPairs, color: selectedColor)
                if isNew {
                    Button {
                        themeViewModel.addTheme(theme)
                        dismiss()
                    } label: {
                        Text("Add")
                    }
                } else {
                    Button {
                        themeViewModel.updateTheme(theme)
                        dismiss()
                    } label: {
                        Text("Done")
                    }
                }
            }
        }
        .onAppear {
            if !isNew {
                name = theme.name
                emojis = theme.emojis
                numberOfPairs = theme.numberOfPairsOfCards
                selectedColor = theme.color
            }
        }
    }
}

#Preview("New") {
    NavigationStack {
        ThemeDetailsView(theme: ThemeModel.Theme.sampleTheme, isNew: true)
            .environment(ThemeViewModel())
    }
}

#Preview("Edit") {
    NavigationStack {
        ThemeDetailsView(theme: ThemeModel.Theme.sampleTheme)
            .environment(ThemeViewModel())
    }
}

struct ColorToSelectView: View {
    let color: Color
    let isSelected: Bool

    var body: some View {
        RoundedRectangle(cornerRadius: 8, style: .continuous)
            .fill(color)
            .frame(width: 44, height: 60)
            .overlay(
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .stroke(lineWidth: 2)
                    .foregroundStyle(.ultraThinMaterial)
            )
            .overlay(
                VStack {
                    if isSelected {
                        Image(systemName: "checkmark.circle")
                            .foregroundStyle(.white)
                            .padding(4)
                    } else {
                        EmptyView()
                    }
                },
                alignment: .bottomTrailing
            )
    }
}
