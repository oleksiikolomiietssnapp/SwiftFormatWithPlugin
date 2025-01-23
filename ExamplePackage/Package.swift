// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ExamplePackage",
    products: [
        .library(
            name: "ExamplePackage",
            targets: ["ExamplePackage"]
        )
    ],
    targets: [
        .target(
            name: "ExamplePackage",
            plugins: [
                .plugin(
                    name: "SwiftFormatPlugin"
                )
            ]
        ),
        .plugin(
            name: "SwiftFormatPlugin",
            capability: .buildTool(),
            path: "Plugins/SwiftFormatPlugin"
        ),
    ]
)
