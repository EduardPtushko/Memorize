//
//  ButtonStyleViewModifier.swift
//  Memorize
//
//  Created by Eduard Ptushko on 08.04.2024.
//

import SwiftUI

struct ButtonStyleViewModifier: ButtonStyle {
    let scale: CGFloat
    let opacity: Double
    let brightness: Double

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? scale : 1)
            .opacity(configuration.isPressed ? opacity : 1)
            .brightness(configuration.isPressed ? brightness : 0)
    }
}

public extension View {
    func asButton(scale: CGFloat = 0.95, opacity: Double = 1, brightness: Double = 0, action: @escaping () -> Void) -> some View {
        Button(action: {
            action()
        }, label: {
            self
        })
        .buttonStyle(ButtonStyleViewModifier(scale: scale, opacity: opacity, brightness: brightness))
    }
}
