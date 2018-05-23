// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "Hello",
    dependencies: [
        .package(url: "https://github.com/IBM-Swift/HeliumLogger.git", .upToNextMinor(from: "1.7.0")),
        // This example uses a fork of Kitura containing new features that will be available in 2.4.
        .package(url: "https://github.com/ddunn2/Kitura.git", .branch("testNewAPI")),
        .package(url: "https://github.com/ddunn2/Kitura-StencilTemplateEngine.git", .branch("testNewAPI"))
    ],
    targets: [
        .target(
            name: "Hello",
            dependencies: [
                "HeliumLogger",
                "Kitura",
                "KituraStencil"
            ]
        ),
    ]
)
