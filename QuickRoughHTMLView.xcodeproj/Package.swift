// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "QuickRoughHTMLView",
    platforms: [
        .iOS(.v14),
        .macOS(.v11)
    ],
    products: [
        .library(
            name: "QuickRoughHTMLView",
            targets: ["QuickRoughHTMLView"]
        )
    ],
    targets: [
        .target(
            name: "QuickRoughHTMLView",
            path: "QuickRoughHTMLView"
        )
    ]
)
