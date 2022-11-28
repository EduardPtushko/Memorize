//
//  ContentView.swift
//  Memorize
//
//  Created by Eduard on 22.11.2022.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack{
            Grid{
                GridRow {
                    Text(viewModel.theme.name.capitalized)
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .foregroundColor(.teal)
                    Color.clear
                              .gridCellUnsizedAxes([ .vertical])
                    Text("Your score: ")
                        .font(.title3)
                        .foregroundColor(.gray)
                    +   Text("\(viewModel.score)")
                        .foregroundColor(.black.opacity(0.9))
                        .font(.title2)
                }
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: EmojiMemoryGame())
            .preferredColorScheme(.light)
        ContentView(viewModel: EmojiMemoryGame())
            .preferredColorScheme(.dark)
       
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
   
    var body: some View {
        let shape = RoundedRectangle(cornerRadius: 20)
        
        ZStack {
            if card.isFaceUp {
                shape.foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content)
                    .font(.largeTitle)
            } else if card.isMatched {
                shape.opacity(0)
            }
            else {
                shape.fill()
            }
        }
    }
}
