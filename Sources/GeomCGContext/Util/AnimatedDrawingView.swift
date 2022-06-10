import UIKit
import Geom
import GeomAPI

public typealias Renderer = (CGContext, Rect, TimeInterval) -> Void

public class AnimatedDrawingView : UIView {

    private let renderer: Renderer

    private let firstTick: TimeInterval
    private var currentTime: TimeInterval

    public init(fps: Int, width: Int, height: Int, renderer: @escaping Renderer) {
        self.renderer = renderer

        self.firstTick = CACurrentMediaTime()
        self.currentTime = 0.0

        let frame = CGRect.init(x: 0, y: 0, width: width, height: height)
        super.init(frame: frame)

        if fps > 0 {
            let displayLink = CADisplayLink(target: self, selector: #selector(tick))
            displayLink.preferredFramesPerSecond = fps
            displayLink.add(to: RunLoop.main, forMode: .default)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    @objc func tick(displaylink: CADisplayLink) {
        setNeedsDisplay()
    }

    public override func draw(_ rect: CGRect) {
        guard let ctx = UIGraphicsGetCurrentContext() else { fatalError() }
        currentTime = CACurrentMediaTime() - firstTick
        renderer(ctx, rect.rect, currentTime)
    }
}
