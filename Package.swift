// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ToDoApp",
    platforms: [
        .macOS(.v12),
        .iOS(.v15)
    ],
    products: [
        .executable(name: "ToDoApp", targets: ["ToDoApp"]),
        .executable(name: "ToDoAppCLI", targets: ["ToDoAppCLI"])
    ],
    targets: [
        // SwiftUI-based macOS app
        .executableTarget(
            name: "ToDoApp",
            dependencies: [],
            path: "Sources/SwiftUI"
        ),
        // Cross-platform command-line app
        .executableTarget(
            name: "ToDoAppCLI",
            dependencies: [],
            path: "Sources/CLI"
        ),
    ]
)
