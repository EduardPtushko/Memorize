//
//  FlyingNumber.swift
//  Memorize
//
//  Created by Eduard Ptushko on 14.04.2024.
//

import SwiftUI

struct FlyingNumber: View {
    let number: Int

    @State private var offset: CGFloat = 0

    var body: some View {
        if number != 0 {
            Text(number, format: .number.sign(strategy: .always()))
                .font(.largeTitle)
                .foregroundStyle(number < 0 ? .red : .green)
                .shadow(color: .black, radius: Constants.radius, x: 1, y: 1)
                .offset(x: 0, y: offset)
                .opacity(offset != 0 ? 0 : 1)
                .onAppear {
                    withAnimation(.easeIn(duration: 1)) {
                        offset = number < 0 ? Constants.offsetDown : Constants.offsetUp
                    }
                }
                .onDisappear {
                    offset = 0
                }
        }
    }

    private enum Constants {
        static let radius = 1.5
        static let offsetDown: CGFloat = 200
        static let offsetUp: CGFloat = -200
    }
}

#Preview {
    FlyingNumber(number: 2)
}
