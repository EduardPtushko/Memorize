//
//  ContentView.swift
//  Memorize
//
//  Created by Eduard Ptushko on 29.03.2024.
//

import SwiftUI

let vehicles = ["🚗", "🛴", "✈️", "🛵", "⛵️", "🚎", "🚐", "🚛", "🛻", "🏎", "🚂", "🚊", "🚀", "🚁", "🚢", "🛶", "🛥", "🚞", "🚟", "🚃"]
let halloween = ["👻", "🎃", "🕷", "🧟‍♂️", "🧛🏼‍♀️", "☠️", "👽", "🦹‍♀️", "🦇", "🌘", "⚰️", "🔮"]

let animals = ["🦑", "🦧", "🦃", "🦚", "🐫", "🦉", "🦕", "🦥", "🐸", "🐼", "🐺", "🦈"]

struct ContentView: View {
    @State private var emojis: [String] = vehicles

    @State private var cardCount = 4

    var body: some View {
        VStack(spacing: 20.0) {
            Text("Memorize!")
                .font(.largeTitle)

            ScrollView {
                cards
            }
            Spacer()
            cardCountAdjusters
        }
        .padding()
    }

    private var cardCountAdjusters: some View {
        HStack(spacing: 40.0) {
            themeButton(theme: vehicles, icon: "car", name: "Vehicle")
            themeButton(theme: halloween, icon: "ev.plug.dc.chademo", name: "Hellowen")
            themeButton(theme: animals, icon: "tortoise", name: "Animals")
        }
    }

    private func themeButton(theme: [String], icon: String, name: String) -> some View {
        Button {
            emojis = theme.shuffled()
        } label: {
            VStack {
                Image(systemName: icon)
                    .font(.title)
                Text(name)
                    .font(.subheadline)
            }
        }
    }

    private var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
            ForEach(emojis, id: \.self) { emoji in
                CardView(content: emoji)
                    .aspectRatio(2 / 3, contentMode: .fit)
            }
        }
        .foregroundStyle(.orange)
    }
}

#Preview {
    ContentView()
}

struct CardView: View {
    let content: String
    @State var isFaceUp = false

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
