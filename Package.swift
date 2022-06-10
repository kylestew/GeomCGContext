// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "GeomCGContext",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "GeomCGContext",
            targets: ["GeomCGContext"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/kylestew/SwiftGeom",
            branch: "ether"
        )
    ],
    targets: [
        .target(
            name: "GeomCGContext",
            dependencies: [
                .product(name: "Geom", package: "SwiftGeom"),
            ]),
    ]
)
