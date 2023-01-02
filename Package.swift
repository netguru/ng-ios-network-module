// swift-tools-version:5.4
import PackageDescription

let package = Package(
    name: "NGiOSNetworkModule",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "NGiOSNetworkModule",
            targets: ["NGiOSNetworkModule"]),
    ],
    dependencies: [
        .package(url: "https://github.com/nicklockwood/SwiftFormat", from: "0.50.4"),
    ],
    targets: [
        .target(
            name: "NGiOSNetworkModule",
            dependencies: []),
        .testTarget(
            name: "NGiOSNetworkModuleTests",
            dependencies: ["NGiOSNetworkModule"]),
    ]
)
