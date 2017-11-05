import PackageDescription

let package = Package(
	name: "pm10-server",
	targets: [],
	dependencies: [
		.Package(url: "https://github.com/PerfectlySoft/Perfect-HTTPServer.git", majorVersion: 3),
        .Package(url: "https://github.com/tid-kijyun/Kanna.git", majorVersion: 2)
	]
)
