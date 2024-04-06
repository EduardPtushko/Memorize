//
//  RootView.swift
//  Memorize
//
//  Created by Eduard Ptushko on 05.04.2024.
//

import SwiftUI

struct ThemeItem: Identifiable {
    var id: String = UUID().uuidString
    let theme: ThemeModel.Theme
    let mode: Mode

    enum Mode: String {
        case add
        case edit
    }
}

struct RootView: View {
    @State private var model = ThemeViewModel()

    @State private var path = NavigationPath()
    @State private var editMode: EditMode = .inactive
    @State private var editThemeItem: ThemeModel.Theme?

    @State private var themeItem: ThemeItem?

    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(model.themes) { theme in
                    NavigationLink(value: theme) {
                        VStack(alignment: .leading) {
                            Text(theme.name.capitalized)
                                .font(/*@START_MENU_TOKEN@*/ .title/*@END_MENU_TOKEN@*/)
                                .foregroundStyle(theme.color)

                            let emojisString = theme.emojis.joined(separator: "")
                            let title = theme.emojis.count == theme.numberOfPairsOfCards ? "All of \(emojisString)" : "\(theme.numberOfPairsOfCards) pairs from \(emojisString)"
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
                .onDelete { _ in
                }
                .onMove(perform: { _, _ in
                })
            }
            .navigationDestination(for: ThemeModel.Theme.self, destination: { theme in
                EmojiMemoryGameView(viewModel: EmojiMemoryGame(theme: theme))
            })
            .listStyle(.plain)
            .navigationTitle("Memorize")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        themeItem = ThemeItem(theme: ThemeModel.Theme.default, mode: .add)
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
                .environment(model)
            }
        }
    }
}

#Preview {
    RootView()
}
