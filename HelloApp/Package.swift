// swift-tools-version: 5.10
import PackageDescription

let package = Package(
    name: "HelloApp",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .executable(name: "HelloApp", targets: ["HelloApp"])
    ],
    dependencies: [
        .package(path: "../Packages/AppCore")
    ],
    targets: [
        .executableTarget(
            name: "HelloApp",
            dependencies: [.product(name: "AppCore", package: "AppCore")],
            path: "Sources/HelloApp"
        )
    ]
)
