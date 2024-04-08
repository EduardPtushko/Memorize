//
//  ThemeDetailsView.swift
//  Memorize
//
//  Created by Eduard Ptushko on 06.04.2024.
//

import SwiftData
import SwiftUI

struct ThemeDetailsView: View {
    enum Field: Hashable {
        case name
        case emoji
    }

    @FocusState private var focusedField: Field?

    @Bindable var theme: Theme
    @State private var name = ""
    @State private var emoji = ""
    @State private var emojis: [String] = []
    @State private var numberOfPairs = 0
    @State private var selectedColor = RGBA(color: Color.red)

    @Environment(\.modelContext)
    private var modelContext

    @Environment(\.dismiss)
    var dismiss

    let colors = [
        Color.red,
        Color.blue,
        Color.black,
        Color.green,
        Color.gray,
        Color.brown,
        Color.cyan,
        Color.indigo,
        Color.mint,
        Color.orange,
        Color.pink,
    ]
    let isNew: Bool

    init(theme: Theme, isNew: Bool = false) {
        self.theme = theme
        self.isNew = isNew
    }

    var body: some View {
        Form {
            nameSection
            emojisSection
            addEmojiSection
            numberOfPairsSection
            colorsSection
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
                if isNew {
                    let theme = Theme(
                        name: name,
                        emojis: emojis,
                        numberOfPairsOfCards: numberOfPairs,
                        color: selectedColor
                    )
                    Button {
                        modelContext.insert(theme)
                        dismiss()
                    } label: {
                        Text("Add")
                    }
                    .disabled(emojis.count < 2)
                } else {
                    Button {
                        theme.numberOfPairsOfCards = numberOfPairs
                        theme.color = selectedColor
                        theme.emojis = emojis
                        theme.name = name

                        dismiss()
                    } label: {
                        Text("Done")
                    }
                    .disabled(emojis.count < 2)
                }
            }
        }
        .onAppear {
            focusedField = .name
            if !isNew {
                name = theme.name
                emojis = theme.emojis
                numberOfPairs = theme.numberOfPairsOfCards
                selectedColor = theme.color
            }
        }
    }
}

extension ThemeDetailsView {
    private var nameSection: some View {
        Section {
            TextField("", text: $name)
                .focused($focusedField, equals: .name)
                .onSubmit {
                    focusedField = .emoji
                }
        } header: {
            Text("Theme Name")
                .font(.headline)
        }
    }

    private var emojisSection: some View {
        Section {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 44), spacing: 2)], spacing: 2) {
                ForEach(emojis, id: \.self) { emoji in
                    Text(emoji)
                        .font(.largeTitle)
                        .padding(4)
                        .background(Color.black.opacity(0.001))
                        .asButton {
                            guard let index = emojis.firstIndex(where: { $0 == emoji }) else { return }
                            emojis.remove(at: index)
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
    }

    private var addEmojiSection: some View {
        Section {
            TextField("Emoji", text: $emoji)
                .keyboardType(.default)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .focused($focusedField, equals: .emoji)
                .onChange(of: emoji) { newValue in
                    if newValue.containsOnlyEmoji {
                        emoji = newValue
                    } else {
                        emoji = newValue.compactMap { str in
                            str.isEmoji ? String(str) : ""
                        }
                        .joined()
                    }
                }
                .onSubmit {
                    emojis = Array(Set(emojis + emoji.split(separator: "").map { String($0) }))
                    emoji = ""
                    emoji = ""
                }
        } header: {
            HStack {
                Text("Add Emoji")
                    .font(.headline)
            }
        }
    }

    private var numberOfPairsSection: some View {
        Section {
            Stepper("\(numberOfPairs) Pairs", value: $numberOfPairs, in: 0...emojis.count)
                .onChange(of: emojis) { value in
                    if numberOfPairs > value.count {
                        numberOfPairs = value.count
                    }
                }
        } header: {
            HStack {
                Text("Card Count")
                    .font(.headline)
            }
        }
    }

    private var colorsSection: some View {
        Section {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 44), spacing: 4)], spacing: 8) {
                ForEach(
                    colors,
                    id: \.self
                ) { color in
                    ColorToSelectView(color: color, isSelected: RGBA(color: color) == selectedColor)
                        .onTapGesture {
                            withAnimation {
                                selectedColor = RGBA(color: color)
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
}

#Preview("New") {
    NavigationStack {
        ThemeDetailsView(theme: SampleData.shared.theme, isNew: true)
    }
    .modelContainer(SampleData.shared.modelContainer)
}

#Preview("Edit") {
    NavigationStack {
        ThemeDetailsView(theme: SampleData.shared.theme)
    }
    .modelContainer(SampleData.shared.modelContainer)
}
