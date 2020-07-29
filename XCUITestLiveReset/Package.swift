// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GRPC_LiveReset",
    platforms: [
        .iOS(.v13)
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/grpc/grpc-swift.git", .exact("1.0.0-alpha.14")),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "GRPC_LiveReset",
            dependencies: [.product(name: "GRPC", package: "grpc-swift")],
            path: "Classes",
            sources: ["Fake.swift"]),
    ]
)
