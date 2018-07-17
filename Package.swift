// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "pm10-server",
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0"),

        // 🔵 Swift ORM (queries, models, relations, etc) built on SQLite 3.
        .package(url: "https://github.com/vapor/fluent-sqlite.git", from: "3.0.0-rc.2"),

        .package(url: "https://github.com/tid-kijyun/Kanna.git", from: "4.0.0")
    ],
    targets: [
        .target(name: "App", dependencies: ["FluentSQLite", "Vapor", "Kanna"]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: ["App"])
    ]
)
