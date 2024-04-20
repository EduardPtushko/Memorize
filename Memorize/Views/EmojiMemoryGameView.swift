//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Eduard Ptushko on 29.03.2024.
//

import SwiftData
import SwiftUI

struct EmojiMemoryGameView: View {
    typealias Card = MemoryGame<String>.Card
    var viewModel: EmojiMemoryGame
    @Namespace private var dealingNamespace

    let aspectRation: CGFloat = 2 / 3
    private let dealAnimation: Animation = .easeInOut(duration: 0.5)
    private let dealInterval: TimeInterval = 0.15
    private let deckWidth: CGFloat = 50

    var body: some View {
        VStack(spacing: 20.0) {
            cards
                .foregroundStyle(viewModel.color)
//            deck
//                .foregroundStyle(viewModel.color)
        }
        .onAppear {
            deal()
        }
        .navigationTitle(viewModel.theme.name.capitalized)
        .padding()
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Score: \(viewModel.score)")
                    .animation(nil)
            }

            ToolbarItem(placement: .topBarTrailing) {
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
            withAnimation {
                viewModel.newGame()
            }
        } label: {
            Text("New Game")
        }
    }

    private var cards: some View {
        EmojiLazyGrid(items: viewModel.cards, aspectRation: aspectRation) { card in
            if isDealt(card) {
                CardView(card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
                    .padding(4)
                    .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
                    .zIndex(scoreChange(causedBy: card) != 0 ? 1 : 0)
                    .onTapGesture {
                        choose(card)
                    }
            }
        }
    }

    @State private var dealt = Set<Card.ID>()

    private func isDealt(_ card: Card) -> Bool {
        dealt.contains(card.id)
    }

    private var undealtCards: [Card] {
        viewModel.cards.filter { !isDealt($0) }
    }

    private var deck: some View {
        ZStack {
            ForEach(undealtCards) { card in
                CardView(card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
            }
        }
        .frame(width: deckWidth, height: deckWidth / aspectRation)
        .onTapGesture {
            deal()
        }
    }

    private func deal() {
        var delay: TimeInterval = 0
        for card in viewModel.cards {
            withAnimation(dealAnimation.delay(delay)) {
                _ = dealt.insert(card.id)
            }
            delay += dealInterval
        }
    }

    private func choose(_ card: Card) {
        withAnimation {
            let scoreBeforeChoosing = viewModel.score
            viewModel.choose(card)
            let scoreChange = viewModel.score - scoreBeforeChoosing
            lastScoreChange = (scoreChange, causedByCardId: card.id)
        }
    }

    @State private var lastScoreChange = (0, causedByCardId: "")

    private func scoreChange(causedBy card: Card) -> Int {
        let (amount, id) = lastScoreChange
        return card.id == id ? amount : 0
    }
}

#Preview {
    NavigationStack {
        EmojiMemoryGameView(
            viewModel: EmojiMemoryGame(
                theme: SampleData.shared.theme
            )
        )
    }
    .modelContainer(SampleData.shared.modelContainer)
}
