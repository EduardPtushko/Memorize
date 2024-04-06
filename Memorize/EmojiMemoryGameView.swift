//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Eduard Ptushko on 29.03.2024.
//

import SwiftUI

struct EmojiMemoryGameView: View {
//    @Environment(EmojiMemoryGame.self)
//    let theme: ThemeModel.Theme
    var viewModel: EmojiMemoryGame

//    init(theme: ThemeModel.Theme, viewModel: EmojiMemoryGame) {
//        self.theme = theme
//        self.viewModel = viewModel
//
//    }

    let aspectRation: CGFloat = 2 / 3

    var body: some View {
        VStack(spacing: 20.0) {
            cards
                .foregroundStyle(viewModel.color)
//                .animation(.default, value: viewModel.cards)
        }
        .navigationTitle(viewModel.theme.name.capitalized)
        .padding()
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                Text("Score: \(viewModel.score)")
                    .frame(maxWidth: .infinity, alignment: .leading)
                Button {} label: {
                    withAnimation {
                        newGame
                    }
                }
            }
        }
    }

    private var newGame: some View {
        Button {
            viewModel.newGame()
        } label: {
            Text("New Game")
        }
    }

    private var cards: some View {
        EmojiLazyGrid(items: viewModel.cards, aspectRation: aspectRation) { card in
            CardView(card)
                .padding(4)
                .onTapGesture {
                    withAnimation {
                        viewModel.choose(card: card)
                    }
                }
        }
    }
}

#Preview {
    NavigationStack {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame(theme: ThemeModel.Theme(name: "animals", emojis: SampleData.animals, numberOfPairsOfCards: 2, color: Color.red)))
    }
}
