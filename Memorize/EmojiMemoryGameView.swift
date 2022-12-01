//
//  ContentView.swift
//  Memorize
//
//  Created by Eduard on 22.11.2022.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack{
            HStack {
                Text(viewModel.theme.name.capitalized)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(.teal)
                
                Spacer()
                Spacer()
                Text("Your score: ")
                    .font(.title3)
                    .foregroundColor(.gray)
                +   Text("\(viewModel.score)")
                    .foregroundColor(.black.opacity(0.9))
                    .font(.title2)
            }
            
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    }
                }
            }
            .foregroundColor(.red)
            
            Button("New Game") {
                viewModel.newGame()
            }
            .padding()
            .padding(.horizontal, 8)
            .foregroundColor(.white)
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .fill(.cyan.opacity(0.9))
            }
        }
        .padding(.horizontal)
    }
}

struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame(themeModel: ThemeModel()))
            .preferredColorScheme(.light)
        EmojiMemoryGameView(viewModel: EmojiMemoryGame(themeModel: ThemeModel()))
            .preferredColorScheme(.dark)
        
    }
}

struct CardView: View {
    let card: EmojiMemoryGame.Card
    
    var body: some View {
        GeometryReader { geometry in
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            
            ZStack {
                if card.isFaceUp {
                    shape.foregroundColor(.white)
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    Text(card.content)
                        .font(font(size: geometry.size))
                } else if card.isMatched {
                    shape.opacity(0)
                }
                else {
                    shape.fill()
                }
            }
        }
    }
    
    private func font(size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 20
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.8
    }
    
}
