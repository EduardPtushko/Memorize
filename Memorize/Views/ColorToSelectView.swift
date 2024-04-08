//
//  ColorToSelectView.swift
//  Memorize
//
//  Created by Eduard Ptushko on 08.04.2024.
//

import SwiftUI

struct ColorToSelectView: View {
    let color: Color
    let isSelected: Bool

    var body: some View {
        RoundedRectangle(cornerRadius: 8, style: .continuous)
            .fill(color)
            .frame(width: 44, height: 60)
            .overlay(
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .stroke(lineWidth: 1)
                    .foregroundStyle(.ultraThinMaterial)
            )
            .overlay(
                VStack {
                    if isSelected {
                        Image(systemName: "checkmark.circle")
                            .foregroundStyle(.white)
                            .padding(4)
                    } else {
                        EmptyView()
                    }
                },
                alignment: .bottomTrailing
            )
    }
}

#Preview {
    ColorToSelectView(color: Color.red, isSelected: true)
}
