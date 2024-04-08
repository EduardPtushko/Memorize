//
//  EmojiLazyGrid.swift
//  Memorize
//
//  Created by Eduard Ptushko on 30.03.2024.
//

import SwiftUI

struct EmojiLazyGrid<Item: Identifiable, ContentView: View>: View {
    var items: [Item]
    var aspectRation: CGFloat = 1
    var content: (Item) -> ContentView

    init(items: [Item], aspectRation: CGFloat, @ViewBuilder content: @escaping (Item) -> ContentView) {
        self.items = items
        self.aspectRation = aspectRation
        self.content = content
    }

    var body: some View {
        GeometryReader { proxy in
            let size = gridItemWidthThatFits(count: items.count, size: proxy.size, atAspectRation: aspectRation)
            LazyVGrid(columns: [GridItem(.adaptive(minimum: size), spacing: 0)], spacing: 0) {
                ForEach(items) { item in
                    content(item)
                        .aspectRatio(aspectRation, contentMode: .fit)
                }
            }
        }
    }

    func gridItemWidthThatFits(count: Int, size: CGSize, atAspectRation: CGFloat) -> CGFloat {
        let count = CGFloat(count)
        var columnCount = 1.0

        repeat {
            let width = size.width / columnCount
            let height = width / aspectRation

            let rowCount = (count / columnCount).rounded(.up)
            if rowCount * height < size.height {
                return (size.width / columnCount).rounded(.down)
            }
            columnCount += 1
        } while columnCount < count

        return min(size.width / count, size.height * aspectRation).rounded(.down)
    }
}
