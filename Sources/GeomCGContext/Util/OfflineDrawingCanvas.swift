import CoreGraphics
import Foundation
import AppKit

public struct OfflineDrawingCanvas {

    public let size: CGSize
    public let margin: CGFloat
    public let ctx: CGContext

    public init(size: CGSize, margin: CGFloat = 0.0) {
        self.margin = margin
        self.size = CGSize(width: size.width - margin * 2, height: size.height - margin * 2)
        self.ctx = CGContext(
            data: nil,
            width: Int(size.width),
            height: Int(size.height),
            bitsPerComponent: 8,
            bytesPerRow: 4 * Int(size.width),
            space: CGColorSpace(name: CGColorSpace.sRGB)!,
            bitmapInfo: CGBitmapInfo.byteOrder32Little.rawValue + CGImageAlphaInfo.premultipliedFirst.rawValue
        )!
        ctx.interpolationQuality = .high
        ctx.setAllowsAntialiasing(true)
        ctx.setShouldAntialias(true)

        // flip to make (0, 0) top left
        let flipVertical = CGAffineTransform(
            a: 1, b: 0, c: 0, d: -1, tx: 0, ty: size.height
        )
        ctx.concatenate(flipVertical)

        // translate to account for border
        ctx.translateBy(x: margin, y: margin)
    }

    public func clear(_ color: CGColor = NSColor.black.cgColor) {
        let rect = CGRect(origin: .zero, size: size)
        ctx.saveGState()
        ctx.setFillColor(color)
        ctx.fill(rect.insetBy(dx: -margin, dy: -margin))
        ctx.restoreGState()
    }

    public func preview() -> CGImage? {
        ctx.makeImage()
    }

    public func save(to url: URL) -> Bool {
        guard let cgImage = ctx.makeImage() else { return false}
        let bmpImgRef = NSBitmapImageRep(cgImage: cgImage)
        guard let pngData = bmpImgRef.representation(using: .png, properties: [:]) else {
            return false
        }
        do {
            try pngData.write(to: url)
            return true
        } catch {
            return false
        }
    }
}

extension OfflineDrawingCanvas: CustomPlaygroundDisplayConvertible {
    public var playgroundDescription: Any {
        ctx.makeImage() as Any
    }
}
