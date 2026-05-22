# Trusted Shops iOS SDK

SwiftUI SDK for displaying Trusted Shops trust widgets and handling buyer protection checkout.

![Platform](https://img.shields.io/badge/platform-iOS-blue)
![iOS](https://img.shields.io/badge/iOS-17%2B-blue)
![Swift](https://img.shields.io/badge/Swift-6.2-orange)

## Table of Contents

- [Requirements](#requirements)
- [Installation](#installation)
- [Quick Start](#quick-start)
- [Trustbadge](#trustbadge)
- [Checkout Integration](#checkout-integration)
- [Configuration](#configuration)
- [API Reference](#api-reference)
- [License](#license)

## Requirements

- iOS 17+
- Xcode with Swift 6.2 toolchain
- Swift Package Manager or CocoaPods
- SwiftUI

## Installation

### Swift Package Manager

In Xcode, go to **File > Add Package Dependencies** and enter:

```
https://github.com/trustedshops-public/ios-sdk
```

Or add it directly to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/trustedshops-public/ios-sdk", from: "0.0.1")
]
```

Then add `"trustedshops_ios_sdk"` to your target's dependencies:

```swift
.target(
    name: "YourApp",
    dependencies: ["trustedshops_ios_sdk"]
)
```

### CocoaPods

Add the following to your `Podfile`:

```ruby
pod 'trustedshops_ios_sdk', '~> 0.0.1'
```

Then run:

```sh
pod install
```

## Quick Start

### 1. Initialize the SDK

Call `start` once at app launch, for example in your `App.init()`:

```swift
import trustedshops_ios_sdk

@main
struct MyApp: App {
    init() {
        TrustedShopsSDK.start { options in
            options.integrationId = "your-integration-id"
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
```

### 2. Display the Trustbadge

Place a `TrustbadgeView` in any SwiftUI view:

```swift
import trustedshops_ios_sdk

struct ContentView: View {
    var body: some View {
        TrustbadgeView(type: .horizontal)
    }
}
```

## Trustbadge

### Display Types

The Trustbadge supports two layouts:

```swift
// Compact horizontal banner
TrustbadgeView(type: .horizontal)

// Larger card layout with more detail
TrustbadgeView(type: .card)
```

### Customization

`TrustbadgeView` supports standard SwiftUI modifiers for layout customization:

```swift
TrustbadgeView(type: .horizontal)
    .padding(16)
    .frame(maxWidth: .infinity)
```

## Checkout Integration

### OrderData

Construct an `OrderData` object with the order details. All fields are optional:

```swift
import trustedshops_ios_sdk

let orderData = OrderData(
    email: "buyer@example.com",
    shopOrderId: "ORDER-123",
    amount: 59.99,
    currency: .EUR,
    paymentType: "CREDIT_CARD",
    estimatedDeliveryDate: "2026-04-01",
    products: [
        Product(name: "Wireless Headphones", sku: "WH-001")
    ]
)
```

### Initiate Checkout

Call `initiateCheckout` to start the buyer protection flow. The SDK must be initialized first. This is an `async` method that must be called from an async context:

```swift
await TrustedShopsSDK.initiateCheckout(orderData: orderData)
```

Example in a button action:

```swift
Button("Secure Purchase") {
    Task {
        await TrustedShopsSDK.initiateCheckout(orderData: orderData)
    }
}
```

### Supported Currencies

`CHF`, `EUR`, `GBP`, `PLN`, `NOK`, `SEK`, `DKK`, `RON`, `CZK`

## Configuration

### Multi-Market (Locale-Aware)

For apps operating in multiple markets, pass a `[TargetMarket: String]` map instead of a single `integrationId`. The SDK automatically resolves the correct integration ID based on the device's region:

```swift
TrustedShopsSDK.start { options in
    options.integrationIds = [
        .DEU: "integration-id-de",
        .AUT: "integration-id-at",
        .GBR: "integration-id-gb",
    ]
}
```

The resolution order is:
1. Exact match for the device's region (e.g. `DE` → `.DEU`)
2. `.EUO` fallback (if present in the map)
3. First entry in the map

To manually switch the active market at runtime:

```swift
// Override to a specific market
TrustedShopsSDK.setTargetMarket(.AUT)

// Revert to automatic system locale resolution
TrustedShopsSDK.setTargetMarket(nil)
```

> **Note:** If both `integrationId` and `integrationIds` are set, `integrationIds` takes precedence and a warning is logged.

### Environment

Set the environment during initialization. Defaults to `.production`:

```swift
TrustedShopsSDK.start { options in
    options.integrationId = "your-integration-id"
    options.environment = .production
}
```

| Environment | Description |
|---|---|
| `.production` | Production (default) |

### Logging

Enable SDK logging for debugging:

```swift
TrustedShopsSDK.start { options in
    options.integrationId = "your-integration-id"
    options.logging = SDKLoggingConfig(
        isEnabled: true,
        level: .debug
    )
}
```

| Property | Type | Default | Description |
|---|---|---|---|
| `isEnabled` | `Bool` | `false` | Enable/disable logging |
| `level` | `SDKLogLevel` | `.warning` | Minimum log level |
| `includeOSLog` | `Bool` | `true` | Bridge to Apple's unified logging |
| `redactSensitiveData` | `Bool` | `true` | Redact PII in logs |
| `customHandler` | `SDKLogHandler?` | `nil` | Custom log handler |

**Log levels:** `.off`, `.error`, `.warning`, `.info`, `.debug`, `.trace`

## API Reference

| Symbol | Type | Description |
|---|---|---|
| `TrustedShopsSDK.start(_:completion:)` | Function | Initialize the SDK (call once) |
| `TrustedShopsSDK.shared` | Property | The SDK singleton |
| `TrustedShopsSDK.initiateCheckout(orderData:)` | Async function | Start buyer protection checkout |
| `TrustedShopsSDK.setTargetMarket(_:)` | Function | Override active market (multi-market only), pass `nil` to revert |
| `TrustbadgeView` | SwiftUI View | Displays the Trustbadge widget |
| `TrustbadgeType` | Enum | `.horizontal`, `.card` |
| `TrustedShopsConfig` | Struct | SDK initialization configuration |
| `TrustedShopsEnvironment` | Enum | `.production` |
| `TargetMarket` | Enum | Supported markets (DEU, AUT, GBR, etc.) |
| `OrderData` | Struct | Order information for checkout |
| `Product` | Struct | Product in an order |
| `Currency` | Enum | Supported currencies |
| `SDKLoggingConfig` | Struct | Logging configuration |
| `SDKLogLevel` | Enum | Log levels (off through trace) |

## License

Copyright (c) Trusted Shops SE. All rights reserved.
