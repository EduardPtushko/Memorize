//
//  RootView.swift
//  Memorize
//
//  Created by Eduard Ptushko on 05.04.2024.
//

import SwiftData
import SwiftUI

struct RootView: View {
    @Environment(\.modelContext)
    private var modelContext
    @Query(sort: \Theme.orderIndex)
    private var themes: [Theme]

    @State private var path = NavigationPath()
    @State private var editMode: EditMode = .inactive
    @State private var themeItem: ThemeItem?

    var body: some View {
        NavigationStack(path: $path) {
            Group {
                if !themes.isEmpty {
                    listOfThemes
                        .navigationDestination(for: Theme.self, destination: { theme in
                            EmojiMemoryGameView(viewModel: EmojiMemoryGame(theme: theme))
                        })
                } else {
                    ContentUnavailableView {
                        Label("There is no themes", systemImage: "rectangle.stack.person.crop")
                    }
                }
            }
            .navigationTitle("Memorize")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        themeItem = ThemeItem(theme: Theme.default, mode: .add)
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    EditButton()
                }
            }
            .environment(\.editMode, $editMode)
            .sheet(item: $themeItem) { themeItem in
                NavigationStack {
                    switch themeItem.mode {
                    case .add:
                        ThemeDetailsView(theme: themeItem.theme, isNew: true)
                    case .edit:
                        ThemeDetailsView(theme: themeItem.theme)
                    }
                }
            }
        }
    }

    private func deleteTheme(indexSet: IndexSet) {
        for index in indexSet {
            modelContext.delete(themes[index])
        }
    }

    private func move(from: IndexSet, to: Int) {
        var updatedThemes = themes
        updatedThemes.move(fromOffsets: from, toOffset: to)
        for (index, theme) in updatedThemes.enumerated() {
            theme.orderIndex = index
        }
    }

    struct ThemeItem: Identifiable {
        var id: String = UUID().uuidString
        let theme: Theme
        let mode: Mode

        enum Mode: String {
            case add
            case edit
        }
    }
}

extension RootView {
    private var listOfThemes: some View {
        List {
            ForEach(themes) { theme in
                NavigationLink(value: theme) {
                    VStack(alignment: .leading) {
                        Text(theme.name.capitalized)
                            .font(.title)
                            .foregroundStyle(Color(rgba: theme.color))
                        let emojisString = theme.emojis.joined(separator: "")
                        let title = theme.emojis.count == theme.numberOfPairsOfCards
                            ? "All of \(emojisString)"
                            : "\(theme.numberOfPairsOfCards) pairs from \(emojisString)"
                        Text(title)
                            .font(.footnote)
                            .lineLimit(1)
                    }
                    .allowsHitTesting(editMode == .active)
                    .onTapGesture {
                        if editMode == .active {
                            themeItem = ThemeItem(theme: theme, mode: .edit)
                        }
                    }
                }
            }
            .onDelete(perform: deleteTheme)
            .onMove(perform: move)
        }
        .listStyle(.plain)
    }
}

#Preview {
    RootView()
        .modelContainer(SampleData.shared.modelContainer)
}
