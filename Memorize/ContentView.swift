//
//  ContentView.swift
//  Memorize
//
//  Created by Eduard Ptushko on 29.03.2024.
//

import SwiftUI

struct ContentView: View {
    let emojis: [String] = ["👻", "🎃", "🕷", "🧟‍♂️", "🧛🏼‍♀️", "☠️", "👽", "🦹‍♀️", "🦇", "🌘", "⚰️", "🔮"]

    @State private var cardCount = 4

    var body: some View {
        VStack(spacing: 20.0) {
            ScrollView {
                cards
            }
            Spacer()
            cardCountAdjusters
        }
        .padding()
    }

    private var cardCountAdjusters: some View {
        HStack {
            cardRemover
            Spacer()
            cardAdder
        }
        .imageScale(.large)
        .font(.largeTitle)
    }

    private var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
            ForEach(0..<cardCount, id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2 / 3, contentMode: .fit)
            }
        }
        .foregroundStyle(.orange)
    }

    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button("", systemImage: symbol) {
            cardCount += offset
        }
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }

    private var cardRemover: some View {
        cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus")
    }

    private var cardAdder: some View {
        cardCountAdjuster(by: 1, symbol: "rectangle.stack.badge.plus")
    }
}

#Preview {
    ContentView()
}

struct CardView: View {
    let content: String
    @State var isFaceUp = true

    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}
