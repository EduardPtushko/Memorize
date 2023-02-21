//
//  ContentView.swift
//  Memorize
//
//  Created by Eduard on 22.11.2022.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
  
    private func zIndex(of card: EmojiMemoryGame.Card) -> Double {
        -Double(
            game.cards.firstIndex(where: { $0.id == card.id}) ?? 0
        )
    }
    
    var body: some View {
        
        VStack{
            gameBody
        }
        .padding()
    }
    
    var gameBody: some View {
        AspectVGrid(items: game.cards, aspectRation: 2/3) { card in
            if  !card.isFaceUp && card.isMatched{
                Color.clear
            } else {
                CardView(card: card)
                    .padding(4)
                    .zIndex(zIndex(of: card))
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 1)) {
                            game.choose(card)
                        }
                    }
            }
        }
        .foregroundColor(.red)
        
    }
    
    private struct CardConstants {
        static let color = Color.red
        static let aspectRation: CGFloat = 2/3
        static let dealDuration: Double = 0.5
        static let totalDealDuration: Double = 2
        static let undealtHeight: CGFloat = 90
        static let undealtWidth = undealtHeight * aspectRation
    }
}


extension EmojiMemoryGameView {
 
    var newGameButton: some View {
        Button("New Game") {
            game.restart()
        }
        .padding()
        .padding(.horizontal, 8)
        .foregroundColor(.white)
        .background {
            RoundedRectangle(cornerRadius: 8)
                .fill(.cyan.opacity(0.9))
        }
    }
}


struct CardView: View {
    let card: EmojiMemoryGame.Card
    @State private var animatedBonusRemaining: Double = 0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: .degrees(0 - 90), endAngle: .degrees((1 - animatedBonusRemaining) * 360 - 90))
                            .onAppear {
                                animatedBonusRemaining = card.bonusRemaining
                                withAnimation(.linear(duration: card.bonusTimeRemaining)) {
                                    animatedBonusRemaining = 0
                                }
                            }
                    } else {
                        Pie(startAngle: .degrees(0 - 90), endAngle: .degrees((1 - card.bonusRemaining) * 360 - 90))
                    }
                }
                .opacity(0.3)
                .padding(5)
                Text(card.content)
                    .rotationEffect(Angle(degrees: card.isMatched ? 360 : 0))
                    .animation(.easeOut(duration: 1).repeatForever(autoreverses: false), value: card.isMatched)
                    .font(.system(size: DrawingConstants.fontSize))
                    .scaleEffect(scale(thatFits: geometry.size))
            }
        }
        .cardify(isFaceUp: card.isFaceUp)
        
    }
    
    private func scale(thatFits size: CGSize) -> CGFloat {
        min(size.width, size.height) / (DrawingConstants.fontSize / DrawingConstants.fontScale)
    }
    
    
    private struct DrawingConstants {
        static let fontScale: CGFloat = 0.7
        static let fontSize: CGFloat = 32
    }
    
}


struct EmojiMemoryGameView_Previews: PreviewProvider {
    static let game = EmojiMemoryGame(themeModel: ThemeModel())
    //        game.choose(game.cards.first!)
    static var previews: some View {
        
        
        VStack{
            EmojiMemoryGameView(game: game )
                .preferredColorScheme(.light)
        }
        
        //        EmojiMemoryGameView(viewModel: EmojiMemoryGame(themeModel: ThemeModel()))
        //            .preferredColorScheme(.dark)
        
    }
}
