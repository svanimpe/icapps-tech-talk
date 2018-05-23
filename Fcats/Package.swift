// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "Fcats",
    dependencies: [
        .package(url: "https://github.com/IBM-Swift/HeliumLogger.git", .upToNextMinor(from: "1.7.0")),
        // This example uses a fork of Kitura containing new features that will be available in 2.4.
        .package(url: "https://github.com/ddunn2/Kitura.git", .branch("testNewAPI")),
        .package(url: "https://github.com/ddunn2/Kitura-StencilTemplateEngine.git", .branch("testNewAPI")),
        .package(url: "https://github.com/OpenKitten/MongoKitten.git", .upToNextMinor(from: "4.1.0")),
        .package(url: "https://github.com/IBM-Swift/SwiftyRequest.git", .upToNextMinor(from: "1.1.0")),
    ],
    targets: [
        .target(
            name: "Main",
            dependencies: [
                "Fcats"
            ]
        ),
        .target(
            name: "Fcats",
            dependencies: [
                "HeliumLogger",
                "Kitura",
                "KituraStencil",
                "MongoKitten"
            ]
        ),
        .testTarget(
            name: "FcatsTests",
            dependencies: [
                "Fcats",
                "SwiftyRequest"
            ]
        )
    ]
)
