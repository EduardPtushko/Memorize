//
//  Cardify.swift
//  Memorize
//
//  Created by Eduard on 05.12.2022.
//

import SwiftUI


struct Cardify: Animatable, ViewModifier {
    var rotation: Double
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    
    func body(content: Content) -> some View {
        let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
        
        ZStack {
            if rotation < 90 {
                shape.foregroundColor(.white)
                shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
            }  else {
                shape.fill()
            }
            content
                .opacity(rotation < 90  ? 1 : 0)
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0, 1, 0))
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
