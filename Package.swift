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
    targets: [
        .target(
            name: "NGiOSNetworkModule",
            dependencies: []),
        .testTarget(
            name: "NGiOSNetworkModuleTests",
            dependencies: ["NGiOSNetworkModule"]),
    ]
)
