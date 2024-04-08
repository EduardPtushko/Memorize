//
//  Pie.swift
//  Memorize
//
//  Created by Eduard Ptushko on 03.04.2024.
//

import CoreGraphics
import SwiftUI

struct Pie: Shape {
    var startAngle: Angle = .zero
    let endAngle: Angle
    var clockwise = true

    func path(in rect: CGRect) -> Path {
        let startAngle = startAngle - .degrees(90)
        let endAngle = endAngle - .degrees(90)

        let center: CGPoint = .init(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        let start = CGPoint(
            x: center.x + radius * cos(startAngle.radians),
            y: center.y + radius * sin(startAngle.radians)
        )

        var path = Path()

        path.move(to: center)
        path.addLine(to: start)
        path.addArc(
            center: center,
            radius: radius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: !clockwise
        )

        return path
    }
}
