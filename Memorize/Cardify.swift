//
//  Cardify.swift
//  Memorize
//
//  Created by Eduard on 05.12.2022.
//

import SwiftUI


struct Cardify: ViewModifier {
    let isFaceUp: Bool
    
    func body(content: Content) -> some View {
      
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            
            ZStack {
                if isFaceUp {
                    shape.foregroundColor(.white)
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                }  else {
                    shape.fill()
                }
                content
                    .opacity(isFaceUp ? 1 : 0)
            }
        
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 20
        static let lineWidth: CGFloat = 3
        
    }
    
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        modifier(Cardify(isFaceUp: isFaceUp))
    }
}
