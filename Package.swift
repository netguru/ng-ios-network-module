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
            targets: ["NgNetworkModule"]),
    ],
    dependencies: [
        .package(url: "https://github.com/nicklockwood/SwiftFormat", from: "0.50.4"),
    ],
    targets: [
        .target(
            name: "NgNetworkModule",
            dependencies: []),
        .testTarget(
            name: "NgNetworkModuleTests",
            dependencies: ["NgNetworkModule"]),
    ]
)
