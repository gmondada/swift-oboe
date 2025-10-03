// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-oboe",
    products: [
        .library(
            name: "SwiftOboe",
            targets: ["SwiftOboe"]
        ),
    ],
    dependencies: [
        .package(name: "oboe", path: "../../../big/oboe")
    ],
    targets: [
        .target(
            name: "SwiftOboe",
            dependencies: ["oboe", "OboeBridge"],
            swiftSettings: [.interoperabilityMode(.Cxx)]
        ),
        .target(
            name: "OboeBridge",
            dependencies: ["oboe"]
        ),
        .testTarget(
            name: "SwiftOboeTests",
            dependencies: ["SwiftOboe"],
            swiftSettings: [.interoperabilityMode(.Cxx)]
        ),
    ]
)
