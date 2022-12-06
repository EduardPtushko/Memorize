//
//  AspectVGrid.swift
//  Memorize
//
//  Created by Eduard on 05.12.2022.
//

import SwiftUI


struct AspectVGrid<Item, ItemView>: View where ItemView: View, Item: Identifiable {
    let items: [Item]
    let aspectRation: CGFloat
    let content: (Item) -> ItemView
    
    init(items: [Item], aspectRation: CGFloat, @ViewBuilder content: @escaping (Item) -> ItemView) {
        self.items = items
        self.aspectRation = aspectRation
        self.content = content
    }
    
    var body: some View {
        VStack{
            GeometryReader { geometry in
                let width = widthThatFits(itemCount: items.count, in: geometry.size, itemAspectRatio: aspectRation)
                
                LazyVGrid(columns: [adaptiveGridItem(width: width)], spacing: 0) {
                    ForEach(items) { item in
                        content(item)
                            .aspectRatio(aspectRation, contentMode: .fit)
                    }
                }
            }
            Spacer(minLength: 0)
        }
    }
    
    private func adaptiveGridItem(width: CGFloat) -> GridItem {
        var item =  GridItem(.adaptive(minimum: width))
        item.spacing = 0
        return item
    }
    
    
    private func widthThatFits(itemCount: Int, in size: CGSize, itemAspectRatio: CGFloat) -> CGFloat {
        var columnCount = 1
        var rowCount = itemCount
        repeat {
            let itemWidth = size.width / CGFloat(columnCount)
            let itemHeight = itemWidth / itemAspectRatio
            if  CGFloat(rowCount) * itemHeight < size.height {
                break
            }
            columnCount += 1
            rowCount = (itemCount + (columnCount - 1)) / columnCount
        } while columnCount < itemCount
        if columnCount > itemCount {
            columnCount = itemCount
        }
        return floor(size.width / CGFloat(columnCount))
    }
}
