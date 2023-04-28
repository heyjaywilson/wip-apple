// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "wip",
    platforms: [.iOS(.v16)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(name: "wip", targets: ["wip"]),
        .library(name: "API", targets: ["API"]),
        .library(name: "AppCore", targets: ["AppCore"]),
        .library(name: "AppView", targets: ["AppView"]),
        .library(name: "NewProjectCore", targets: ["NewProjectCore"]),
        .library(name: "NewProjectView", targets: ["NewProjectView"]),
        .library(name: "ProjectView", targets: ["ProjectView"]),
        .library(name: "WIPKit", targets: ["WIPKit"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", branch: "navigation-beta"),
        .package(url: "https://github.com/SFSafeSymbols/SFSafeSymbols.git", .upToNextMajor(from: "4.1.1")),
        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.6.1"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "wip",
            dependencies: []),
        .testTarget(
            name: "wipTests",
            dependencies: ["wip"]),
        .target(
            name: "API",
            dependencies: [
                "WIPKit",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
                .product(name: "Alamofire", package: "Alamofire")
            ]
        ),
        .target(
            name: "AppCore",
            dependencies: [
                "NewProjectCore",
            .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ]
        ),
        .testTarget(name: "AppCoreTests", dependencies: ["AppCore"]),
        .target(
            name: "AppView",
            dependencies: [
                "AppCore", "NewProjectView", "ProjectView",
                .product(name: "SFSafeSymbols", package: "SFSafeSymbols")
            ]
        ),
        .target(
            name: "ProjectView",
            dependencies: [
                "WIPKit"]
        ),
        .target(
            name: "NewProjectCore",
            dependencies: [
            "API", "WIPKit",
            .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ]
        ),
        .target(
            name: "NewProjectView",
            dependencies: [
                "NewProjectCore",
                .product(name: "SFSafeSymbols", package: "SFSafeSymbols")
            ]
        ),
        .target(
            name: "WIPKit",
            dependencies: [
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
                ]
        )
    ]
)
