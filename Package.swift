// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RollAndKeepSystem",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.

		.library(
            name: "RollAndKeepSystem",
            targets: ["RollAndKeepSystem"])
    ],
    dependencies: [
		.package(url: "git@github.com:mwalles2/Roll.git", from: "1.0.0-beta"),
		.package(url: "git@github.com:mwalles2/Die.git", from: "1.0.0-beta")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "RollAndKeepSystem",
            dependencies: ["Die", "Roll"]),
        .testTarget(
            name: "RollAndKeepSystemTests",
            dependencies: ["RollAndKeepSystem"]),
    ]
)
