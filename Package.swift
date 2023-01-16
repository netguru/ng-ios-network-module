// swift-tools-version:5.4
import PackageDescription

let package = Package(
    name: "NgNetworkModule",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "NgNetworkModule",
            targets: ["NgNetworkModule"]
        ),
        .library(
            name: "ReactiveNgNetworkModule",
            targets: ["ReactiveNgNetworkModule"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/nicklockwood/SwiftFormat", from: "0.50.4")
    ],
    targets: [
        .target(
            name: "NgNetworkModule",
            dependencies: []
        ),
        .target(
            name: "ReactiveNgNetworkModule",
            dependencies: ["NgNetworkModule"]
        ),
        .testTarget(
            name: "NgNetworkModuleTests",
            dependencies: ["NgNetworkModule"]
        ),
        .testTarget(
            name: "ReactiveNgNetworkModuleTests",
            dependencies: ["ReactiveNgNetworkModule"]
        )
    ]
)
