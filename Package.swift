// swift-tools-version: 6.2

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
        .package(url: "https://github.com/gmondada/oboe.git", from: "1.9.3"),
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
