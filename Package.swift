// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DragGestureKit",
    platforms: [
        .iOS(.v14),
        .visionOS(.v1)
    ],
    products: [
        .library(
            name: "DragGestureKit",
            targets: ["DragGestureKit"]),
    ],
    targets: [
        .target(
            name: "DragGestureKit"),
        .testTarget(
            name: "DragGestureKitTests",
            dependencies: ["DragGestureKit"]),
    ]
)
