import CoreGraphics
import GeomAPI
import Geom

public extension Rect {
    var cgRect: CGRect {
        CGRect(x: pos.x, y: pos.y, width: width, height: height)
    }
}

public extension Vec {
    var cgPoint: CGPoint {
        CGPoint(x: x, y: y)
    }
}

public extension CGRect {
    var rect: Rect {
        Rect(pos: Vec(Double(self.origin.x),
                      Double(self.origin.y)),
             size: Vec(Double(self.width),
                       Double(self.height)))
    }

//    static func fromCenter(x: Double, y: Double, width: Double, height: Double) -> CGRect {
//        let px = x - width / 2.0
//        let py = y - height / 2.0
//        return CGRect(x: px, y: py, width: width, height: height)
//    }

    var centered: CGRect {
        self.offsetBy(dx: -width/2, dy: -height/2)
    }
}
