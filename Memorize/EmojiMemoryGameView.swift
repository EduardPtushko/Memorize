//
//  ContentView.swift
//  Memorize
//
//  Created by Eduard on 22.11.2022.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
    
    var body: some View {
        VStack{
            HStack {
                Text(game.theme.name.capitalized)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(.teal)
                
                Spacer()
                Spacer()
                Text("Your score: ")
                    .font(.title3)
                    .foregroundColor(.gray)
                +   Text("\(game.score)")
                    .foregroundColor(.black.opacity(0.9))
                    .font(.title2)
            }
            
                AspectVGrid(items: game.cards, aspectRation: 2/3) { card in
                    if !card.isFaceUp && card.isMatched{
                        Rectangle()
                            .opacity(0)
                    } else {
                        CardView(card: card)
                            .padding(4)
                            .onTapGesture {
                                game.choose(card)
                            }
                    }
                }
                .foregroundColor(.red)
//                .padding(.horizontal)
           
            Button("New Game") {
                game.newGame()
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


struct CardView: View {
    let card: EmojiMemoryGame.Card
    
    var body: some View {
        GeometryReader { geometry in
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            
            ZStack {
                if card.isFaceUp {
                    shape.foregroundColor(.white)
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    Pie(startAngle: .degrees(0 - 90), endAngle: .degrees(110 - 90))
                        .opacity(0.3)
                        .padding(5)
                        
                    Text(card.content)
                        .font(font(size: geometry.size))
                }  else {
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
        static let fontScale: CGFloat = 0.7
    }
    
}


struct EmojiMemoryGameView_Previews: PreviewProvider {
   
    
    static var previews: some View {
        let game = EmojiMemoryGame(themeModel: ThemeModel())
        game.choose(game.cards.first!)
        
      return  EmojiMemoryGameView(game: game )
            .preferredColorScheme(.light)
        
//        EmojiMemoryGameView(viewModel: EmojiMemoryGame(themeModel: ThemeModel()))
//            .preferredColorScheme(.dark)
        
    }
}
