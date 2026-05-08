// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "Mesh",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "Mesh",
            targets: ["Mesh"]
        ),
    ],
    targets: [
        .target(
            name: "Mesh",
            dependencies: [],
            path: "Sources/Mesh"
        ),
        .testTarget(
            name: "MeshTests",
            dependencies: ["Mesh"],
            path: "Tests/MeshTests"
        ),
    ]
)
