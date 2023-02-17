// swift-tools-version:5.4
import PackageDescription

let package = Package(
    name: "NgNetworkModule",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "NgNetworkModuleCore",
            targets: ["NgNetworkModuleCore"]
        ),
        .library(
            name: "ReactiveNgNetworkModule",
            targets: ["ReactiveNgNetworkModule"]
        ),
        .library(
            name: "ConcurrentNgNetworkModule",
            targets: ["ConcurrentNgNetworkModule"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "NgNetworkModuleCore",
            dependencies: []
        ),
        .target(
            name: "ReactiveNgNetworkModule",
            dependencies: ["NgNetworkModuleCore"]
        ),
        .target(
            name: "ConcurrentNgNetworkModule",
            dependencies: ["NgNetworkModuleCore"]
        ),
        .testTarget(
            name: "NgNetworkModuleCoreTests",
            dependencies: ["NgNetworkModuleCore"]
        ),
        .testTarget(
            name: "ReactiveNgNetworkModuleTests",
            dependencies: ["ReactiveNgNetworkModule"]
        ),
        .testTarget(
            name: "ConcurrentNgNetworkModuleTests",
            dependencies: ["ConcurrentNgNetworkModule"]
        )
    ]
)
