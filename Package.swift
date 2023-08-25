// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "StrapiSwiftCross",
    platforms: [
        .macOS(.v10_15),
		.iOS(.v14)
    ],
    products: [
        .library(
            name: "StrapiSwiftCross",
            targets: ["StrapiSwiftCross"]),
    ],
    dependencies: [
        .package(url: "https://github.com/WeTransfer/Mocker.git", .upToNextMajor(from: "3.0.0")),
        .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "StrapiSwiftCross"),
        .testTarget(
            name: "StrapiSwiftCrossTests",
            dependencies: [
                "StrapiSwiftCross",
                "Mocker"
            ]),
    ]
)
