Pod::Spec.new do |spec|
  spec.name         = "trustedshops_ios_sdk"
  spec.version      = "1.0.0-rc.1"
  spec.summary      = "Trusted Shops SDK for iOS"
  spec.description  = <<-DESC
    The Trusted Shops iOS SDK provides UI components for displaying trustmarks,
    shop grades, buyer protection, and checkout integration in iOS applications.
  DESC

  spec.homepage     = "https://github.com/trustedshops-public/ios-sdk"
  spec.license      = { :type => "Proprietary", :text => "Copyright (c) Trusted Shops SE. All rights reserved." }
  spec.author       = { "Trusted Shops SE" => "https://www.trustedshops.com/" }

  spec.platform       = :ios, "17.0"
  spec.swift_versions = "6.0"

  # Binary distribution: pulls the signed XCFramework zip attached to the
  # GitHub Release for this version. Asset is named
  # `<product>-<version>.xcframework.zip`.
  spec.source = {
    :http => "https://github.com/trustedshops-public/ios-sdk/releases/download/v#{spec.version}/trustedshops_ios_sdk-#{spec.version}.xcframework.zip"
  }

  spec.vendored_frameworks = "trustedshops_ios_sdk.xcframework"
end
