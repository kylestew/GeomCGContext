import Foundation
import CoreGraphics
import Geom

public extension Line {
    func stroke(_ ctx: CGContext) {
        ctx.move(to: self.points[0].cgPoint)
        ctx.addLine(to: self.points[1].cgPoint)
    }
}

public extension Circle {
    func stroke(_ ctx: CGContext) {
        ctx.strokeEllipse(in: bounds.cgRect.centered)
    }
}

public extension Rect {
    func stroke(_ ctx: CGContext) {
        ctx.addRect(cgRect)
    }
}
