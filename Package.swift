// swift-tools-version: 6.2
import PackageDescription

// The `url` and `checksum` are bumped on every release.
// The XCFramework zip is built and signed by the private source repo
// and attached to each GitHub Release.

let package = Package(
    name: "trustedshops_ios_sdk",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "trustedshops_ios_sdk",
            targets: ["trustedshops_ios_sdk"]
        )
    ],
    targets: [
        .binaryTarget(
            name: "trustedshops_ios_sdk",
            url: "https://github.com/trustedshops-public/ios-sdk/releases/download/v1.0.0-rc.1/trustedshops_ios_sdk-1.0.0-rc.1.xcframework.zip",
            checksum: "25de9c5950fd6460c7be5b6a102e0a2cff271892fb0370f6173edc24e9f03db8"
        )
    ]
)
