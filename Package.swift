// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Stand alone swift package manager runnable",
    dependencies: [
        .package(url: "https://github.com/shibapm/PackageConfig.git", from: "0.13.0"),
        .package(url: "https://github.com/shibapm/Komondor.git", from: "1.0.5"),
        .package(url: "https://github.com/nicklockwood/SwiftFormat.git", from: "0.44.0"),
        .package(url: "https://github.com/realm/SwiftLint.git", from: "0.39.0"),
    ],
    targets: [
        .target(
            name: "fake",
            dependencies: [],
            path: "XCUITestLiveReset/Classes",
            sources: ["Fake.swift"]),
    ]
)

#if canImport(PackageConfig)
import PackageConfig

let config = PackageConfiguration([
    "komondor": [
        "pre-commit": [
            "echo '[🤖 Starting pre-commit tasks]'",
            "echo '[🤖 Running Swiftformat]'",
            "./format_staged_swift_file.sh;" ,
            "git add .",
            "echo '[🤖 Pre-commit tasks complete]'",
        ],
        "pre-push": [
            "echo '[🤖 Starting pre-push tasks]'",
            "echo '[🤖 Running SwiftLint]'",
            "./lint_staged_swift_file.sh;" ,
            "echo '[🤖 Pre-push tasks complete]'",
        ],
    ],
]).write()
#endif

//  "echo '[🤖 Adding changes to commit]'",
//  "xcrun agvtool next-version -all",
//  "echo '[🤖 Pre-commit tasks complete]'",
