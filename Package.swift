// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "pm10-server",
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "3.3.0"),
        .package(url: "https://github.com/tid-kijyun/Kanna.git", from: "5.0.0"),
        .package(url: "https://github.com/vapor/leaf.git", from: "3.0.0")
    ],
    targets: [
        .target(name: "App", dependencies: ["Vapor", "Kanna", "Leaf"]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: ["App"])
    ]
)
