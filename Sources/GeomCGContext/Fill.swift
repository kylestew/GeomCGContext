import CoreGraphics
import Geom

public extension Circle {
    func fill(_ ctx: CGContext) {
        ctx.fillEllipse(in: bounds.cgRect.centered)
    }
}

public extension Rect {
    func fill(_ ctx: CGContext) {
        ctx.fill(cgRect.centered)
    }
}

